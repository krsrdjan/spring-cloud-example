package com.sk.springcloud.bookstore.repository;

import com.sk.springcloud.bookstore.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookRepository extends JpaRepository<Book, Long> {
    
    Book findByTitle(String title);
    
    Book findByAuthor(String author);
    
    Book findByIsbn(String isbn);
} 