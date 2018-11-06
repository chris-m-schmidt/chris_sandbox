connection: "thelook_events_redshift"

include: "*.view.lkml"

explore: order_items {
  join: users {
    relationship: many_to_one
    sql_on: ${order_items.user_id} = ${users.id} ;;
  }
}
