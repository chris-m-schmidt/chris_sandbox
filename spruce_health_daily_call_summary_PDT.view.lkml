view: daily_call_summary {
  derived_table: {
    #disabling PDT due to failing regenerator queries (km 4/20)
#     datagroup_trigger: default_datagroup
#     distribution_style: even
#     sortkeys: ["call_date", "entity_id"]
    sql:
        WITH daily_calls AS (
                            SELECT
                              DATE(call.created) AS call_date,
                              call.caller_entity_id AS caller_entity_id,
                              entity_contact.entity_id AS answerer_entity_id,
                              call.answered_by_phone_number AS answered_by_phone_number,
                              call.outgoing AS outgoing,
                              call.sent_to_voicemail AS sent_to_voicemail,
                              call.left_voicemail AS left_voicemail,
                              call.status AS status,
                              call.call_trigger AS call_trigger
                              call.parent_call_sid AS parent_call_sid
                            FROM excoms.call AS call
                            LEFT JOIN directory.entity_contact AS entity_contact
                                    ON call.answered_by_phone_number = entity_contact.value
                            )
        , daily_outbound_calls AS (
                                  SELECT
                                    call_date,
                                    caller_entity_id AS entity_id,
                                    COUNT(*) AS outbound_call_count
                                  FROM daily_calls
                                  WHERE call_trigger IN ('OUTGOING_PROXY_CALL', 'OUTGOING_SIP_CALL', 'OUTGOING_WIRELESS_CALL') AND parent_call_sid IS NULL
                                  GROUP BY 1,2
                                  )
        , daily_answered_calls AS (
                                  SELECT
                                    call_date,
                                    answerer_entity_id AS entity_id,
                                    COUNT(*) AS answered_call_count
                                  FROM daily_calls
                                  WHERE call_trigger = 'INCOMING_CALL' AND sent_to_voicemail IS NOT TRUE
                                  GROUP BY 1,2
                                  )

        SELECT ROW_NUMBER() OVER(ORDER BY call_date, entity_id) AS id, *
          FROM daily_outbound_calls
              JOIN daily_answered_calls
                ON daily_outbound_calls.call_date = daily_answered_calls.call_date
                AND daily_outbound_calls.entity_id = daily_answered_calls.entity_id
    ;;
  }

  dimension: id {
    type: number
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension_group: call {
    type: time
    datatype: date
    timeframes: [date, week, month]
    sql: ${TABLE}.call_date ;;
  }

  dimension: entity_id {
    type: string
    sql: ${TABLE}.entity_id ;;
  }

  dimension: outbound_call_count {
    type: number
    sql: ${TABLE}.outbound_call_count ;;
  }

  dimension: answered_call_count {
    type: number
    sql: ${TABLE}.answered_call_count ;;
  }

  measure: total_outbound_calls {
    type: sum
    sql: ${outbound_call_count} ;;
  }

  measure: total_answered_calls {
    type: sum
    sql: ${answered_call_count} ;;
  }
}
