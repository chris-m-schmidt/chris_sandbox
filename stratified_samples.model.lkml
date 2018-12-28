connection: "thelook_events_redshift"

include: "*.view.lkml"

explore: order_items {
  join: users {
    relationship: many_to_one
    sql_on: ${order_items.user_id} = ${users.id} ;;
  }

  join: build_stratified_user_sample {
    relationship: one_to_one
    sql_on: ${users.id} = ${build_stratified_user_sample.id} ;;
  }
}

datagroup: foo {
  sql_trigger:  select current_date ;;
  max_cache_age: "24 hours"
}
