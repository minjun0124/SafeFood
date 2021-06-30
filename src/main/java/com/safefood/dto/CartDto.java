package com.safefood.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CartDto {
    private String id;
    private int code;
    private int quantity;
    private String name;
    private String imgPath;

    public CartDto(String id, int code, int quantity) {
        this.id = id;
        this.code = code;
        this.quantity = quantity;
    }
}
