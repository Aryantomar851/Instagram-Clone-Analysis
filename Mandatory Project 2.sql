use ig_clone;
#2 We want to reward the user who has been around the longest, Find the 5 oldest users.
select * from users order by  created_at limit 5 ;

#3 To target inactive users in an email ad campaign, find the users who have never posted a photo.
select username from users where id not in ( select user_id from photos );

#4 Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
select username most_liked from users u 
inner join photos p on  u.id = p.user_id
  where p.id = (select photo_id from likes group by photo_id  order by count(*) desc limit 1 );
  
#5 The investors want to know how many times does the average user post. 
select avg(c) avg_user_post from  ( select  count(id)  c from photos group by user_id) as n;
     

#6 A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
with cte as 
(select tag_id , count(photo_id) most_used_tags  from photo_tags 
group by tag_id order by most_used_tags desc limit 5)
select tags.tag_name most_used_tags   from cte 
inner join  tags on tags.id = cte.tag_id  ;

#7 To find out if there are bots, find users who have liked every single photo on the site.
 select username bots from users where id  = any( select user_id
from likes
group by user_id
having COUNT(distinct photo_id) = (select COUNT(*) from photos));






#8 Find the users who have created instagramid in may and select top 5 newest joinees from it?
select username newest_joinee from users where month(created_at) = '5' order by created_at desc limit 5;

#9 Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos?
select username from users where username regexp '^c.*[0-9]$' and 
id in (select user_id from photos where id in ( select photo_id  from likes ) ) ;

#10 Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.
select user_id , count(u.id) no_of_photos , username from photos p
inner join users u on  p.user_id = u.id
group by user_id having no_of_photos between 3 and 5 limit 30;










  