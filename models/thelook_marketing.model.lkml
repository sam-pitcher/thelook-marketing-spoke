connection: "default_bigquery_connection"

# 1. Include Governed Views & Explore Templates from the Central Hub
include: "//thelook-antigravity/thelook_views/**/*.view.lkml"
include: "//thelook-antigravity/explores/thelook_hub.explore.lkml"

# 2. Include Local Marketing Spoke Views & Refinements
include: "/views/*.view.lkml"

# Default datagroup required by central PDTs (user_order_facts)
datagroup: thelook_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM `sampitcher-playground.the_look_ca.order_items_table` ;;
  max_cache_age: "4 hours"
}

datagroup: marketing_daily_datagroup {
  sql_trigger: SELECT MAX(id) FROM `sampitcher-playground.the_look_ca.order_items_table` ;;
  max_cache_age: "2 hours"
}

access_grant: pii_data {
  user_attribute: can_see_pii
  allowed_values: ["Yes", "yes", "true"]
}

persist_with: marketing_daily_datagroup

# 3. Refined Hub Explores with Marketing Branding (Unhidden for Marketing)
explore: +order_items {
  hidden: no
  label: "Marketing: Campaign Attribution & Orders"
  description: "Marketing-specific order analysis with channel attribution"
  group_label: "Marketing Spoke"
}

explore: +users {
  hidden: no
  label: "Marketing: Customer Acquisition & Audiences"
  description: "User demographic and marketing traffic channel analysis"
  group_label: "Marketing Spoke"
}

# 4. Extended Custom Departmental Explore (Extends Pattern)
explore: marketing_campaign_cohorts {
  view_name: users_ext
  label: "Marketing: Cohort Performance Analysis"
  group_label: "Marketing Spoke"
}

# 5. Spoke-Exclusive Ingested Data Explore (Events & Web Traffic)
explore: events {
  label: "Marketing: Web Traffic & Event Clickstream"
  group_label: "Marketing Spoke"
  description: "Exclusive departmental clickstream data ingested directly into the Marketing Spoke"

  join: users {
    type: left_outer
    relationship: many_to_one
    sql_on: ${users.id} = ${events.user_id} ;;
  }
}
