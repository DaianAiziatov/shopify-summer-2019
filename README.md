<img src="/shopify-summer-2019/Assets.xcassets/AppIcon.appiconset/180.png" align="right"/>

## Shopify Mobile Developer Intern Challenge - Summer 2019

- ### Problem

You're a successful Shopify merchant with many collections of products! You’d like to keep an eye on your collections. Let’s create an app that displays a Custom Collections list page and a Collection Details page. Your app will fetch the data from the 
<a href="https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6">
Shopify Custom Collections REST API
</a>.

<b>Custom Collections list page:</b> A simple list of every custom collection (e.g. In our above
response you will see we will need cells for: Aerodynamic, Durable and Small). Tapping on a
collection launches the Collection Details page.
<b>Collection Details page:</b> A list of every product for a specific collection. Each row in the list
needs to contain, at a minimum:
- The name of the product
- The total available inventory across all variants of the product
- The collection title
- The collection image

<br>
To fetch the products for a custom collection you will need to retrieve the list of collects in a specific collection first: https://shopicruit.myshopify.com/admin/collects.json?collection_id=68424466488&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6

(replace collection_id with the appropriate id you retrieved from the collections list)

Then load the product details with each product_id in the collect list: https://shopicruit.myshopify.com/admin/products.json?ids=2759137027,2759143811&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6

- ### Extra

Feeling adventurous? In the <b>Collection Details page</b> add the collection details in a card at the top that contains the image, title and body_html of the selected collection. See if you can make the details card height flexible to display the whole description.

## Demo

- ### Screenshots
 
![Shopify](demos/screenshots.png)

- ### Application

![Shopify](demos/demo.gif)
