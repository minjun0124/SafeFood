package com.safefood.model.domain;

import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import static javax.persistence.FetchType.*;

@Entity
@Getter
@Setter
public class Question {

    @Id
    @GeneratedValue
    @Column(name = "qCode")
    private int qCode;

    @NonNull
    private LocalDateTime date;

    @NonNull
    private String title;

    private String contents;

    @NonNull
    private boolean answered = false;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(fetch = LAZY)
    private List<Answer> answers = new ArrayList<>();
}
