view: spruce_health_calls {
  sql_table_name: excomms.call ;;

  dimension: call_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.call_sid ;;
  }

  dimension: caller_entity_id {
    type: string
    sql: ${TABLE}.caller_entity_id ;;
  }

  dimension: callee_entity_id {
    type: string
    sql: ${TABLE}.callee_entity_id ;;
  }

  dimension: answered_by_phone_number {
    type: string
    sql: ${TABLE}.answered_by_phone_number ;;
  }

  dimension: outgoing {
    type: yesno
    sql: ${TABLE}.outgoing ;;
  }

  dimension: sent_to_voicemail {
    type: yesno
    sql: ${TABLE}.sent_to_voicemail ;;
  }

  dimension_group: created {
    type: time
    timeframes: [raw, date, week, month, year]
    sql: ${TABLE}.created ;;
    datatype: timestamp
    convert_tz: no
  }

  dimension_group: answered {
    type: time
    timeframes: [raw, date, week, month, year]
    sql: ${TABLE}.answered ;;
    datatype: timestamp
    convert_tz: no
  }

  dimension_group: completed {
    type: time
    timeframes: [raw, date, week, month, year]
    sql: ${TABLE}.completed ;;
    datatype: timestamp
    convert_tz: no
  }

  measure: answered_call_count {
    description: "Use this for counting incoming calls that were answered"
    type: count
    filters: {
      field: outgoing
      value: "No"
    }
    filters: {
      field: sent_to_voicemail
      value: "No"
    }
  }
}
