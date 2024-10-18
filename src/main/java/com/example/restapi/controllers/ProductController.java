package com.example.restapi.controllers;

import com.example.restapi.entities.Product;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicInteger;
//http://localhost:8085/api/products/1
@RestController
@RequestMapping("/api/products")
public class ProductController {

    private List<Product> products = new ArrayList<>();
    private AtomicInteger idCounter = new AtomicInteger();

    public ProductController() {
        products.add(new Product(idCounter.incrementAndGet(), "Pain", 5.9F, "Alimentaire"));
        products.add(new Product(idCounter.incrementAndGet(), "Paté", 10.99F, "Alimentaire"));
    }

    @GetMapping
    public ResponseEntity<List<Product>> getAllProducts() {
        return ResponseEntity.ok(products);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Product> getProductById(@PathVariable Integer id) {
        Optional<Product> product = products.stream().filter(p -> p.getId().equals(id)).findFirst();
        return product.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Product> createProduct(@RequestBody Product product) {
        product.setId(idCounter.incrementAndGet());
        products.add(product);
        return ResponseEntity.status(HttpStatus.CREATED).body(product);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Product> updateProduct(@PathVariable Integer id, @RequestBody Product updatedProduct) {
        Optional<Product> existingProduct = products.stream().filter(p -> p.getId().equals(id)).findFirst();
        if (existingProduct.isPresent()) {
            Product productToUpdate = existingProduct.get();
            productToUpdate.setPrice(updatedProduct.getPrice());
            productToUpdate.setProductName(updatedProduct.getProductName());
            productToUpdate.setType(updatedProduct.getType());
            return ResponseEntity.ok(productToUpdate);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProduct(@PathVariable Integer id) {
        Optional<Product> existingProduct = products.stream().filter(p -> p.getId().equals(id)).findFirst();
        if (existingProduct.isPresent()) {
            products.remove(existingProduct.get());
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
