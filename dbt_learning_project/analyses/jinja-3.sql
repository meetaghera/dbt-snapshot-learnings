{% set inc_flag = 1 %}
{% set last_load = 3 %}
{% set colm_value = ["sales_id","date_sk","gross_amount"] %}


select 

    {% for i in colm_value %}
        {{ i }}
        {% if not loop.last %}, {% endif %}
    {% endfor %}

from {{ ref('bronze_sales') }}

    {% if inc_flag == 1 %}
        where date_sk > {{ last_load }}
    {% endif %}
