--Most Engaging Videos:
SELECT title, viewCount
FROM [MrBeast_Data].[dbo].[VideoData]
ORDER BY viewCount DESC;

--Top 5 videos with the highest like-to-view ratio:
WITH LikeToViewRatio AS (
    SELECT title, 
           (CAST(likeCount AS DECIMAL) / NULLIF(viewCount, 0)) * 100 AS 'like_to_view_ratio'
    FROM [MrBeast_Data].[dbo].[VideoData]
)
SELECT TOP 5 *
FROM LikeToViewRatio
WHERE like_to_view_ratio IS NOT NULL
ORDER BY like_to_view_ratio DESC;

--Videos with a high comment count relative to their views:
WITH CommentToViewRatio AS (
    SELECT title, 
           (CAST(commentCount AS DECIMAL) / NULLIF(viewCount, 0)) * 100 AS 'comment_to_view_ratio'
    FROM [MrBeast_Data].[dbo].[VideoData]
    WHERE YEAR(publishedAt) > 2022
)
SELECT TOP 5 *
FROM CommentToViewRatio
ORDER BY comment_to_view_ratio DESC;

--Temporal Trends:

--Average view count variation over different days of the week:
WITH ViewCountByDay AS (
    SELECT publishedDay, SUM(viewCount) AS total_viewcount
    FROM [MrBeast_Data].[dbo].[VideoData]
    GROUP BY publishedDay
)
SELECT *
FROM ViewCountByDay
ORDER BY total_viewcount DESC;

--Average like count variation over different days of the week:
WITH LikeCountByDay AS (
    SELECT publishedDay, SUM(likeCount) AS total_likecount
    FROM [MrBeast_Data].[dbo].[VideoData]
    GROUP BY publishedDay
)
SELECT *
FROM LikeCountByDay
ORDER BY total_likecount DESC;

--Top Days for Publishing:

--Day of the week for videos with the most views:
SELECT publishedDay, SUM(viewCount)
FROM [MrBeast_Data].[dbo].[VideoData]
GROUP BY publishedDay;

--Publishing Frequency:

--Average number of videos published by MrBeast in a week:
SELECT COUNT(video_id) / DATEDIFF(wk, MIN(publishedAt), MAX(publishedAt))
FROM [MrBeast_Data].[dbo].[VideoData];
