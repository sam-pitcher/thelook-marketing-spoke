include: "//thelook-antigravity/thelook_views/users.view.lkml"

# ==============================================================================
# MARKETING EXTENSION VIEW: users_ext
# ==============================================================================
# Creates an explicit new copy/variant of 'users' to avoid naming collisions.
# Naming standard: [view_name]_ext.view.lkml
# ==============================================================================

view: users_ext {
  extends: [users]

  dimension: campaign_cohort {
    type: string
    description: "Marketing cohort segmentation derived from signup quarter"
    sql: CONCAT('Cohort-', ${created_quarter}) ;;
  }

  measure: cohort_user_count {
    type: count_distinct
    sql: ${id} ;;
    description: "Count of unique users within campaign cohort"
  }
}
