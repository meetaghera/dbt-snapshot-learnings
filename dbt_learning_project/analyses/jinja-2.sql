{% set apples = ["gala","red delicious","Honey","Fuji"] %}

{% for i in apples %}
    {% if i != "Honey" %}
        {{ i }}
    {% else %}
        I hate {{ i }}
    {% endif %}
{% endfor %}

