-- 1 -- 
 select name, releasedate from album
 where releasedate between  '2018-01-01' and '2018-12-31'
 
-- 2 -- 
SELECT track."name",track.tracklength
FROM track
WHERE
	tracklength =(SELECT MAX(track.tracklength) FROM track);
-- 3 -- 
select name, tracklength from track
WHERE tracklength >= 3.5;

-- 4 --
select name from collections
where release_year between  '2018-01-01' and  '2020-01-01';

-- 5 -- 
SELECT artist."name"
FROM artist
WHERE artist."name" NOT LIKE '%% %%';

-- 6 -- 
select name from track
where name like 'my%';