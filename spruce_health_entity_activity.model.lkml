connection: "thelook_events_redshift"
#
# include: "*.view.lkml"
#
# datagroup: default_datagroup {
#   max_cache_age: "24 hours"
#   sql_trigger: SELECT CURRENT_DATE ;;
# }
#
# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: daily_call_summary {
#   join: providers {
#     type: full_outer
#     relationship: many_to_one
#     sql_on: ${daily_call_summary.entity_id} = ${providers.id} ;;
#   }
# }
