package com.safefood.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class IntakeDto {
    private int intakeCode;
    private String id;
    private int code;
    private int quantity;
    private String name;
    private String imgPath;

    public IntakeDto(String id, int code, int quantity) {
        this.id = id;
        this.code = code;
        this.quantity = quantity;
    }
}
