view: providers {
  derived_table: {
    datagroup_trigger: default_datagroup
    distribution_style: all
    sortkeys: ["id"]
    sql:
        WITH entity AS (SELECT * FROM directory.entity)

        SELECT
          users.id AS id,
          organization.id AS organization_id,
          users.account_id AS account_id,
          COALESCE(NULLIF(users.custom_display_name,''), users.display_name) AS provider_name,
          COALESCE(NULLIF(organization.custom_display_name,''), organization.display_name) AS organization_name,
          organization.type AS organization_type,
          entity_contact.value AS contact_value,
          entity_contact.type AS contact_type,
          user.created AS created_date
        FROM directory.entity_membership
            JOIN entity AS users
              ON entity_membership.entity_id = users.id AND users.type IN ('INTERNAL', 'PHONE')
            JOIN entity AS organization
              ON entity_membership.target_entity_id = organization.id
            LEFT JOIN directory.entity_contact AS entity_contact
              ON entity_membership.entity_id = entity_contact.entity_id AND entity_contact.type IN('PHONE', 'SIP_URI')
        GROUP BY 1,2,3,4,5,6,7,8,9
        ORDER BY 1
    ;;
  }

  dimension: id {
    type: string
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organization_id ;;
  }

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: provider_name {
    type: string
  }

  dimension: contact_value {
    type: string
    sql: ${TABLE}.contact_value ;;
  }
}
