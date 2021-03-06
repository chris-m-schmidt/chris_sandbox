view: order_items {
  sql_table_name: public.order_items ;;

  dimension: id {
    primary_key: yes
    group_label: "ID Dimensions"
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: rank {
    type: number
    sql: SELECT ROW_NUMBER() OVER() FROM ${TABLE} ;;
  }

  dimension_group: created {
    view_label: "Example: Date Groups 1"
    type: time
    timeframes: [
      raw,
      time,
      hour,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
    view_label: "Example: Date Groups 1"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    group_label: "ID Dimensions"
    type: number
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    group_label: "ID Dimensions"
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    view_label: "Example: Date Groups 2"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    view_label: "Example: Date Groups 2"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    html: <p style = "font-family: courier; font-size: 200%">{{rendered_value}}</p> ;;
  }

  dimension: user_id {
    group_label: "ID Dimensions"
    type: number
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }

  measure: count_greater_than_10 {
    type: yesno
    sql: ${count} > 10 ;;
  }

  measure: total_sales {
    type: sum
    sql: ${sale_price} ;;
  }

}
