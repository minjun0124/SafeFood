package com.safefood.dto;

import com.safefood.model.domain.*;
import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class UserDto {
    private String id;
    private String password;
    private String name;
    private Address address;
    private String phone;
    private String allergy;
    private boolean withdraw = false;
    private String grade = "member";

    public UserDto(String userId, String name, Address address
                    , String phone, String allergy) {
        this.id = userId;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.allergy = allergy;
    }
}
