<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>ShopLite • Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: url('https://images.unsplash.com/photo-1612831455544-1f90efc7e6f8?auto=format&fit=crop&w=1950&q=80') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .glass-card {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.25);
            color: #fff;
        }

        .glass-card h3 {
            color: #ff6b6b;
        }

        .form-control {
            border-radius: 12px;
            border: 1.5px solid rgba(255, 255, 255, 0.6); /* borde visible */
            background: rgba(255, 255, 255, 0.35); /* fondo semi-transparente */
            color: #000; /* texto legible */
        }

        .form-control::placeholder {
            color: #555; /* placeholder visible */
        }

        .btn-primary {
            background: linear-gradient(135deg, #ff6b6b, #f06595);
            border: none;
            border-radius: 12px;
        }

        .btn-warning {
            background: linear-gradient(135deg, #ffd43b, #ffa94d);
            border: none;
            border-radius: 12px;
            color: #000;
        }

        .btn-danger {
            background: linear-gradient(135deg, #ff4d4d, #ff6b6b);
            border: none;
            border-radius: 12px;
        }

        .table {
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            border-radius: 15px;
        }

        .table thead th {
            border-bottom: 2px solid rgba(255,255,255,0.3);
        }

        .table tbody tr:hover {
            background: rgba(255,255,255,0.2);
        }

        .alert-danger {
            background: rgba(255, 0, 0, 0.3);
            color: #fff;
            border: none;
        }

        nav.navbar {
            backdrop-filter: blur(8px);
            background: rgba(0,0,0,0.5);
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-dark bg-opacity-50 border-bottom">
    <div class="container">
        <a class="navbar-brand text-light" href="${pageContext.request.contextPath}/home">ShopLite • Admin</a>
    </div>
</nav>

<section class="container my-5" style="max-width:800px;">
    <c:if test="${param.err=='1'}">
        <div class="alert alert-danger">Datos inválidos</div>
    </c:if>

    <!-- Formulario Nuevo/Editar Producto -->
    <div class="glass-card mb-4 p-4">
        <h3 class="mb-3">Nuevo producto</h3>
        <form id="productForm" method="post" action="${pageContext.request.contextPath}/admin" class="row g-3">
            <input type="hidden" name="id" id="productId" value="">
            <input type="hidden" name="action" id="formAction" value="add">
            <div class="col-12">
                <label class="form-label">Nombre</label>
                <input class="form-control" name="name" id="productName" placeholder="Teclado 60%" required>
            </div>
            <div class="col-12">
                <label class="form-label">Precio</label>
                <input class="form-control" name="price" id="productPrice" placeholder="59.99" required>
            </div>
            <div class="col-12">
                <label class="form-label">Stock</label>
                <input class="form-control" name="stock" id="productStock" placeholder="10" required>
            </div>
            <div class="col-12">
                <button type="submit" class="btn btn-primary w-100" id="submitBtn">Guardar</button>
            </div>
        </form>
    </div>

    <!-- Tabla Productos -->
    <div class="glass-card p-4">
        <h3 class="mb-3">Productos existentes</h3>
        <table class="table table-bordered text-white">
            <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Precio</th>
                <th>Stock</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="p" items="${products}">
                <tr>
                    <td>${p.id}</td>
                    <td>${p.name}</td>
                    <td>${p.price}</td>
                    <td>${p.stock}</td>
                    <td>
                        <button class="btn btn-sm btn-warning"
                                onclick="editProduct('${p.id}', '${p.name}', '${p.price}', '${p.stock}')">Editar</button>
                        <form method="post" style="display:inline-block;" action="${pageContext.request.contextPath}/admin">
                            <input type="hidden" name="id" value="${p.id}">
                            <input type="hidden" name="action" value="delete">
                            <button class="btn btn-sm btn-danger">Borrar</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</section>

<script>
    function editProduct(id, name, price, stock) {
        document.getElementById('productId').value = id;
        document.getElementById('productName').value = name;
        document.getElementById('productPrice').value = price;
        document.getElementById('productStock').value = stock;

        document.getElementById('formAction').value = 'edit';
        document.getElementById('submitBtn').textContent = 'Actualizar';
        document.getElementById('productForm').scrollIntoView({ behavior: 'smooth' });
    }
</script>
</body>
</html>