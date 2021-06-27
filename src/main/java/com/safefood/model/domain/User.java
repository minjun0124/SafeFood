package com.safefood.model.domain;

import com.safefood.dto.UserDto;
import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@ToString
public class User {

    @Id
    @Column(name = "user_id")
    @NonNull
    private String id;

    @NonNull
    private String password;

    @NonNull
    private String name;

    private String address;

    @NonNull
    private String phone;

    // Allergy 어떻게 넣을 건지?
    private String allergy;

    @Column(nullable = false, columnDefinition = "char default 'f'")
    private char withdraw = 'f';

    private String grade = "member";

    @Column(nullable = false, columnDefinition = "tinyint default 1")
    private int isAdmin;

    @OneToMany(mappedBy = "user", cascade = CascadeType.REMOVE)
    private List<Cart> carts = new ArrayList<>();

    @OneToMany(mappedBy = "user", cascade = CascadeType.REMOVE)
    private List<Intake> intakes = new ArrayList<>();

    @OneToMany(mappedBy = "user", cascade = CascadeType.REMOVE)
    private List<Notice> notices = new ArrayList<>();

    @OneToMany(mappedBy = "user", cascade = CascadeType.REMOVE)
    private List<Question> questions = new ArrayList<>();

    public User(String userId, String pw, String name, String address, String phone) {
        this.id = userId;
        this.password = pw;
        this.name = name;
        this.address = address;
        this.phone = phone;
    }

    public User() {

    }

    //=============Business Logic ============//

    public void userInfoChange(UserDto userDto) {
        this.setName(userDto.getName());
        this.setAddress(userDto.getAddress());
        this.setAllergy(userDto.getAllergy());
        this.setPhone(userDto.getPhone());
    }
}
