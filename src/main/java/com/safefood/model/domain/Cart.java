package com.safefood.model.domain;

import com.safefood.dto.CartDto;
import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "cart")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Cart {
    @EmbeddedId
    private CartId cartId;

    @MapsId("userid")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    @NonNull
    private User user;

    @MapsId("foodcode")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "food_code")
    @NonNull
    private Food food;

    @NonNull
    private int Quantity;

    public void changeQuantity(int quantity) {
        this.setQuantity(quantity);
    }
}
