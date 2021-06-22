package com.safefood.model.domain;

import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
public class User {

    @Id
    @GeneratedValue
    @Column(name = "user_id")
    @NonNull
    private Long id;

    @NonNull
    private String password;

    @NonNull
    private String name;

    @Embedded
    @NonNull
    private Address address;

    @NonNull
    private String phone;

    // Allergy 어떻게 넣을 건지?
    private String allergy;

    private boolean withdraw = false;

    private String grade = "member";

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Cart> carts = new ArrayList<>();

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Intake> intakes = new ArrayList<>();

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Notice> notices = new ArrayList<>();

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Question> questions = new ArrayList<>();

}
