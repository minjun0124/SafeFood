package com.safefood.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CartDto {
    private String id;
    private int code;
    private int quantity;
}
