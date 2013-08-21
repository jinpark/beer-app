beerfavorites
=================

beerfavorit.es is a beer recommendation and discovery web app written in ruby on rails. It uses collaborative filtering for its recommendation engine. beerfavorit.es allows you to favorite beers that you already love, recommends you beers based on beers that you favorite, save beers that you want to try in the future, find bars where you can try those beers and follow other users that have similar beer tastes as you! 

I'm also available for hire! Contact information is in my profile!

**Data Set**

The dataset used was generously provided by SNAP from Stanford University. It consists of 1,586,259 beer reviews from Beer Advocate, a beer discussion, information and review site. The reviews in the dataset range from Jan 1998 to Nov 2011, over 12 year of reviews. Reviews include product and user information, followed by each of these five ratings, and a plaintext review. Find out more about the dataset at http://snap.stanford.edu/data/web-BeerAdvocate.html 

The dataset was pruned. This was done by only taking beers that were reviewed over 500 times. After this, the dataset was pruned more by only taking reviews that were over 4/5. This guaranteed that the reviews that were left over were only positive reviews. 

There were two ways I could have gone from here. One way was to leave the dataset as is and do collaborative filtering on the fly by writing a quick SQL query that would have gotten common reviewers for a pair of beers. This turned out to be time consuming to calculate on the fly all the time. It took over 5 seconds per query and would have proved impossible to use in a webapp. The other option was to precalculate similarity values between beers and only have the SQL query grab the correct matches. This was also time consuming initially. It took more than a few hours to precalculate the similarity values but after this was calculated, the query for a beer pair dropped down to 10ms and to 5ms when the database was indexed. 

I feel like this was not the best way to do this. This was the first time I was doing collaborative filtering so if you have any suggestions, please contact me!

There is an underlying problem here. The way t

**Web App**

This was a ruby on rails app with UJS/jQuery to help with the front end and user experience. The charts were created with Chartkick/Google Charts, maps are from Google Maps API and the list of bars were generously provided by Taplister's API. Styling was done with SASS and Adobe Illustrator for the topbar bubbles.

**Technologies**

The list of technologies used include

1. Ruby
2. Rails
3. UJS (Unobtrusive Javascript)
4. jQuery
5. Chartkick gem (for beautiful Google Charts)
6. Google Maps API (geocoding and displaying maps)
7. Taplister API
8. SASS



**To run the code:**

1. run bundle install
2. run rake db:migrate
3. run rake import (this will take a while. It's importing a LOT of data so grab a coffee and browse hacker news or reddit for a while!)
4. run rails s
5. Now you're running beerfavorit.es! Go to localhost:3000 in your browser to check it out!

**TO DO**
1. Finish styling
2. Fix map reappending problem
3. Clean up javascript
4. Clean up sass files
5. Include neural network as an alternative to collaborative filtering. (This will be a significant overhaul.)






