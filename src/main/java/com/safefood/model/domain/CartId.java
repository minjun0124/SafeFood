package com.safefood.model.domain;

import lombok.*;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Data
@Embeddable
@AllArgsConstructor
@NoArgsConstructor
public class CartId implements Serializable {
    @Column(name = "user_id")
    private String userid;
    @Column(name = "food_code")
    private int foodcode;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof CartId)) return false;
        CartId cartId = (CartId) o;
        return foodcode == cartId.foodcode && Objects.equals(userid, cartId.userid);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userid, foodcode);
    }
}
