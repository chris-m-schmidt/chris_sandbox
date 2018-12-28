view: activity_by_hour {
  derived_table: {
    sql: SELECT
        PDT_name.provider_id  AS provider_id,
        DATE_TRUNC('hour', PDT_name.created_at) AS created_hour,
        SUM(PDT_name.total_calls) AS total_calls
      FROM PDT_name

      GROUP BY 1,2
       ;;
  }

  dimension: provider_id {
    type: number
  }

  dimension_group: created_hour {
    type: time
    timeframes: [ hour, date, week]
  }

  dimension: total_calls {
    type: number
  }

  dimension: is_active_provider {
    type: yesno
    sql: ${total_calls} > 0  ;;
  }

  measure: active_providers_count {
    type:count_distinct
    sql: ${provider_id} ;;
    filters: {
      field: is_active_provider
      value: "Yes"
    }
  }
}
