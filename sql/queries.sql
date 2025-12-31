-- Chinook SQLite 数据库查询脚本
-- 作者：数据库课程实践
-- 数据库：Chinook_Sqlite.sqlite

-- Q4：艺术家专辑数量 Top 10
SELECT
  ar.Name AS artist,
  COUNT(al.AlbumId) AS album_cnt
FROM Artist ar
JOIN Album al ON al.ArtistId = ar.ArtistId
GROUP BY ar.ArtistId
ORDER BY album_cnt DESC
LIMIT 10;

--------------------------------------------------

-- Q9：客户消费金额 Top 10
SELECT
  c.CustomerId,
  c.FirstName || ' ' || c.LastName AS customer_name,
  c.Country,
  SUM(i.Total) AS total_spent
FROM Customer c
JOIN Invoice i ON i.CustomerId = c.CustomerId
GROUP BY c.CustomerId
ORDER BY total_spent DESC
LIMIT 10;

--------------------------------------------------

-- Q10：曲目收入 Top 10
SELECT
  t.TrackId,
  t.Name AS track_name,
  SUM(il.UnitPrice * il.Quantity) AS revenue
FROM InvoiceLine il
JOIN Track t ON t.TrackId = il.TrackId
GROUP BY t.TrackId
ORDER BY revenue DESC
LIMIT 10;

--------------------------------------------------

-- Q11：艺术家收入 Top 10（多表连接）
SELECT
  ar.Name AS artist,
  SUM(il.UnitPrice * il.Quantity) AS revenue
FROM InvoiceLine il
JOIN Track t ON t.TrackId = il.TrackId
JOIN Album al ON al.AlbumId = t.AlbumId
JOIN Artist ar ON ar.ArtistId = al.ArtistId
GROUP BY ar.ArtistId
ORDER BY revenue DESC
LIMIT 10;

--------------------------------------------------

-- Q12：按月份统计销售额
SELECT
  substr(InvoiceDate, 1, 7) AS year_month,
  SUM(Total) AS revenue
FROM Invoice
GROUP BY year_month
ORDER BY year_month;

--------------------------------------------------

-- Q15：从未被购买过的曲目数量
SELECT
  COUNT(*) AS never_sold_tracks
FROM Track t
LEFT JOIN InvoiceLine il ON il.TrackId = t.TrackId
WHERE il.TrackId IS NULL;
