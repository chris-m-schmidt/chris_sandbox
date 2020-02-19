explore: navigation_bar {}

view: navigation_bar {
  derived_table: {
    sql: select 1 ;;
  }

  dimension: navigation_bar_home {
    type: number
    sql: 1 ;;
    html: <div>
            <button class="btn btn-primary btn-large" style="@{selected_button_style}">Home</button>
            <a class="btn btn-primary btn-large" href="/dashboards/27" style="@{unselected_button_style}">Specialty</a>
            <a class="btn btn-primary btn-large" href="/dashboards/26" style="@{unselected_button_style}">Expenditures</a>
            <a class="btn btn-primary btn-large" href="/dashboards/29" style="@{unselected_button_style}">Utilization</a>
            <a class="btn btn-primary btn-large" href="/dashboards/30" style="@{unselected_button_style}">Care Delivery</a>
            <a class="btn btn-primary btn-large" href="/dashboards/28" style="@{unselected_button_style}">Demographics</a>
            <a class="btn btn-primary btn-large" href="/dashboards/31" style="@{unselected_button_style}">Quick Tips</a>
          </div> ;;
  }
}
