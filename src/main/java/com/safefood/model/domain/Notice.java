package com.safefood.model.domain;

import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

import static javax.persistence.FetchType.*;

@Entity
@Getter
@Setter
public class Notice {

    @Id
    @GeneratedValue
    @Column(name = "notice_num")
    private int num;

    @NonNull
    private String title;
    @NonNull
    private LocalDateTime regDate;

    private String contents;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "user_id")
    private User user;
}
