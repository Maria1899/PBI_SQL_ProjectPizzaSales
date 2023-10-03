SELECT * 
FROM [BD_PROJECT_SALES].[dbo].[Sales_pizza]

/********************* KPIS *************************************************/
 
-- Ingresos totales ----------------------
SELECT 
	SUM([TOTAL_PRICE]) AS TOTAL_INGRESOS
FROM [BD_PROJECT_SALES].[dbo].[Sales_pizza];


-- Venta Promedio Por Pedido --------------
SELECT 
  SUM([TOTAL_PRICE]) / (
    SELECT 
      TOP 1 [ORDER_ID] 
    FROM 
      [BD_PROJECT_SALES].[dbo].[Sales_pizza] 
    ORDER BY 
      [ORDER_ID] DESC
  ) VentaPromedioPorPedido
FROM 
  [BD_PROJECT_SALES].[dbo].[Sales_pizza];


 -- Total de pizzas vendidas -----------------
SELECT
	SUM([QUANTITY]) AS TotalPizzasVendidas
FROM 
  [BD_PROJECT_SALES].[dbo].[Sales_pizza];


 -- Pedidos totales -------------------------
SELECT 
	COUNT(DISTINCT [ORDER_ID]) AS PedidosTotales
FROM 
  [BD_PROJECT_SALES].[dbo].[Sales_pizza];


-- Promedio de pizzas por pedido ------------------
SELECT 
	CAST(
		CAST(SUM([QUANTITY]) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT [ORDER_ID]) AS DECIMAL(10,2)) 
		AS DECIMAL(10,2)
		)
	AS PromedioPizzaPorPedido
FROM 
  [BD_PROJECT_SALES].[dbo].[Sales_pizza];


/********************* EVOLUCION DIARIA DEL TOTAL DE PEDIDOS *************************************************/
SELECT 
	DATENAME(DW,[ORDER_DATE]), 
	COUNT(DISTINCT [ORDER_ID]) AS TOTAL_PEDIDOS
FROM 
  [BD_PROJECT_SALES].[dbo].[Sales_pizza]
GROUP BY DATENAME(DW,[ORDER_DATE]);


/********************* TENDENCIA MENSUAL DEL TOTAL DE PEDIDOS *************************************************/
SELECT 
	DATENAME(MONTH, [ORDER_DATE]), 
	COUNT(DISTINCT [ORDER_ID]) AS TOTAL_PEDIDOS
FROM 
  [BD_PROJECT_SALES].[dbo].[Sales_pizza]
GROUP BY DATENAME(MONTH, [ORDER_DATE]);

/********************* PORCENTAJE DE VENTAS POR TAMAÑO DE PIZZA *************************************************/
SELECT 
  [PIZZA_SIZE], 
  SUM([TOTAL_PRICE]) AS TOTAL_VENTA, 
  CAST(
    SUM([TOTAL_PRICE]) * 100 / (
      SELECT 
        SUM([TOTAL_PRICE]) 
      FROM 
        [BD_PROJECT_SALES].[dbo].[Sales_pizza]
    ) AS DECIMAL (10, 2)
  ) AS Porcentaje_VENTAS 
FROM 
  [BD_PROJECT_SALES].[dbo].[Sales_pizza] 
GROUP BY 
  [PIZZA_SIZE]
ORDER BY [Porcentaje_VENTAS] DESC;


/********************* PORCENTAJE DE VENTAS POR CATEGORIA DE PIZZA *************************************************/
SELECT 
  [PIZZA_CATEGORY], 
  CAST(
    SUM([TOTAL_PRICE]) AS DECIMAL(10, 2)
  ) AS TOTAL_VENTA, 
  CAST(
    SUM([TOTAL_PRICE]) * 100 / (
      SELECT 
        SUM([TOTAL_PRICE]) 
      FROM 
        [BD_PROJECT_SALES].[dbo].[Sales_pizza]
    ) AS DECIMAL (10, 2)
  ) AS Porcentaje_VENTAS 
FROM 
  [BD_PROJECT_SALES].[dbo].[Sales_pizza] 
GROUP BY 
  [PIZZA_CATEGORY] 
ORDER BY 
  [Porcentaje_VENTAS] DESC;


/********************* TOTAL DE PIZZAS VENDIDAS POR CATEGORIA *************************************************/
SELECT 
  [PIZZA_CATEGORY], 
  SUM([QUANTITY]) AS PizzasVendidas
FROM 
  [BD_PROJECT_SALES].[dbo].[Sales_pizza]
GROUP BY [PIZZA_CATEGORY]
ORDER BY [PizzasVendidas] DESC;


/********************* TOP 5 PIZZAS POR INGRESOS *************************************************/
SELECT TOP 5 
  [PIZZA_NAME], 
  SUM([TOTAL_PRICE]) AS PizzasVendidas
FROM 
  [BD_PROJECT_SALES].[dbo].[Sales_pizza]
GROUP BY [PIZZA_NAME]
ORDER BY [PizzasVendidas] DESC;


/********************* BOTTOM 5 PIZZAS POR INGRESOS *************************************************/
SELECT TOP 5 
  [PIZZA_NAME], 
  SUM([TOTAL_PRICE]) AS PizzasVendidas
FROM 
  [BD_PROJECT_SALES].[dbo].[Sales_pizza]
GROUP BY [PIZZA_NAME]
ORDER BY [PizzasVendidas] ASC;

/********************* TOP 5 PIZZAS POR CANTIDAD *************************************************/
SELECT TOP 5 
  [PIZZA_NAME], 
  SUM([QUANTITY]) AS PizzasVendidas
FROM 
  [BD_PROJECT_SALES].[dbo].[Sales_pizza]
GROUP BY [PIZZA_NAME]
ORDER BY [PizzasVendidas] DESC;


/********************* BOTTOM 5 PIZZAS POR CANTIDAD *************************************************/
SELECT TOP 5 
  [PIZZA_NAME], 
  SUM([QUANTITY]) AS PizzasVendidas
FROM 
  [BD_PROJECT_SALES].[dbo].[Sales_pizza]
GROUP BY [PIZZA_NAME]
ORDER BY [PizzasVendidas] ASC;


/********************* Top 5 Pizzas by Total Orders *************************************************/
SELECT TOP 5 
  [PIZZA_NAME], 
  COUNT(DISTINCT [ORDER_ID]) AS TOTAL_ORDENES
FROM
  [BD_PROJECT_SALES].[dbo].[Sales_pizza]
GROUP BY [PIZZA_NAME]
ORDER BY [TOTAL_ORDENES] DESC;


/********************* Borrom 5 Pizzas by Total Orders *************************************************/
SELECT TOP 5 
  [PIZZA_NAME], 
  COUNT(DISTINCT [ORDER_ID]) AS TOTAL_ORDENES
FROM
  [BD_PROJECT_SALES].[dbo].[Sales_pizza]
GROUP BY [PIZZA_NAME]
ORDER BY [TOTAL_ORDENES] ASC;