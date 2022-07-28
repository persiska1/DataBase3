-- 1 --
SELECT
    genre_id,
    COUNT(artist_id) genre_count 
FROM
    artist_genre ag 
GROUP BY
	genre_id;

-- 2 --
SELECT
	c."name" , c.release_year
FROM  collections AS c
WHERE
	(c.release_year  >= '2019-01-01') AND (c.release_year  <= '2020-12-31');

-- 3 --
SELECT t."name", t.tracklength
FROM track AS t 
WHERE
	t.tracklength >= (SELECT AVG(track.tracklength) FROM track);

-- 4 -- 
SELECT distinct artist."name"
FROM artist
WHERE
	artist."name" NOT IN (
	SELECT DISTINCT artist."name"
	FROM album as a
	where a.releasedate <= '2020-01-01' AND a.releasedate >= '2020-12-31'
	);

-- 5 --
SELECT DISTINCT c."name" 
FROM
	collections as c
left join collections_album_track as cat  on c.id = cat.collections_id
left join track as t on t.id = cat.track_id
left join album as a on a.id = t.album_id
left join album_artist as aa on aa.album_id = a.id
left join artist as a2 on aa.id = aa.artist_id
where a.name like '%%Kirkorov%%'
order by c.name;

-- 6 --
SELECT a."name" 
FROM album AS a
left join album_artist aa on a.id = aa.album_id
left join artist a2 on a2.id = aa.artist_id
left join artist_genre ag  on a2.id = ag.artist_id
left join genre as g on g.id = ag.genre_id
group by a."name"
having count(distinct g."name") > 1
order by a."name";

-- 7 --
SELECT t.name
FROM track as t
left join collections_album_track cat on t.id = cat.track_id
WHER cat.track_id is null;

-- 8 -- 

SELECT a2."name" , t.tracklength 
FROM track as t
left join album as a on a.id = t.album_id
left join album_artist as aa on aa.album_id = a.id
left join artist as a2 on a2.id = aa.artist_id
GROP BY a2.name, t.tracklength 
HAVING t.tracklength = (SELECT min(tracklength) FROM track)
ORDER BY a2.name;

-- 9 -- 
SELECT DISTINCT a.name
FROM album as a
left join track as t on t.album_id = a.id
WHERE t.album_id in (
    SELECT album_id
    FROM track
    GROUP BY album_id
 	HAVING count(id) = (
        SELECT count(id)
        FROM track
        GROUP BY album_id
        ORDER BY count
        LIMIT 1
    )
)
ORDER BY a.name;