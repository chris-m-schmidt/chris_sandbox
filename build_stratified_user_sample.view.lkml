view: build_stratified_user_sample {
  derived_table: {
    sql: SELECT sub.*, CAST(RANDOM() AS float) AS random2
         FROM (
              SELECT id, CAST(RANDOM() AS float) AS random1, NTILE({% parameter number_of_strata %}) OVER(ORDER BY random1) AS strata_id
              FROM public.users
              ) AS sub
    ;;
  }

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: strata_id {
    type: number
    sql: ${TABLE}.strata_id ;;
  }

  dimension: proportion_to_sample {
    type: number
    sql: ${TABLE}.random2 ;;
  }

  parameter: number_of_strata {
    type: unquoted
  }
}
