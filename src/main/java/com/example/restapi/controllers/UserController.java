package com.example.restapi.controllers;

import com.example.restapi.entities.User;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicInteger;
//http://localhost:8085/api/users/1
@RestController
@RequestMapping("/api/users")
public class UserController {

    private List<User> users = new ArrayList<>();
    private AtomicInteger idCounter = new AtomicInteger();

    public UserController() {
        users.add(new User(idCounter.incrementAndGet(), "John"));
        users.add(new User(idCounter.incrementAndGet(), "Jane"));
    }

    @GetMapping
    public ResponseEntity<List<User>> getAllUsers() {
        return ResponseEntity.ok(users);
    }

    @GetMapping("/{id}")
    public ResponseEntity<User> getUserById(@PathVariable Integer id) {
        Optional<User> user = users.stream().filter(p -> p.getId().equals(id)).findFirst();
        return user.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<User> createUser(@RequestBody User user) {
        user.setId(idCounter.incrementAndGet());
        users.add(user);
        return ResponseEntity.status(HttpStatus.CREATED).body(user);
    }

    @PutMapping("/{id}")
    public ResponseEntity<User> updateUser(@PathVariable Integer id, @RequestBody User updatedUser) {
        Optional<User> existingUser = users.stream().filter(p -> p.getId().equals(id)).findFirst();
        if (existingUser.isPresent()) {
            User userToUpdate = existingUser.get();
            userToUpdate.setName(updatedUser.getName());
            return ResponseEntity.ok(userToUpdate);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Integer id) {
        Optional<User> existingUser = users.stream().filter(p -> p.getId().equals(id)).findFirst();
        if (existingUser.isPresent()) {
            users.remove(existingUser.get());
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
