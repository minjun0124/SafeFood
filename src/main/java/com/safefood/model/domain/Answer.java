package com.safefood.model.domain;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

import static javax.persistence.FetchType.*;

@Entity
@Getter
@Setter
public class Answer {

    @Id
    @GeneratedValue
    @Column(name = "aCode")
    private int aCode;
    private LocalDateTime date;
    private String contents;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "qCode")
    private Question question;
}
