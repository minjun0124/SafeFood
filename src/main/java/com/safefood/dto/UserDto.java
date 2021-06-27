package com.safefood.dto;

import lombok.Data;

@Data
public class UserDto {
    private String id;
    private String password;
    private String name;
    private String address;
    private String phone;
    private String allergy;
    private boolean withdraw = false;
    private String grade = "member";

    public UserDto(String userId, String name, String address
                    , String phone, String allergy) {
        this.id = userId;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.allergy = allergy;
    }
}
