package com.safefood.model.domain;

import com.safefood.dto.CartDto;
import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "cart")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Cart {
    @EmbeddedId
    private CartId cartId;

    @MapsId("userId")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @MapsId("foodCode")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "food_code")
    private Food food;

    private int Quantity;

    public void changeQuantity(int quantity) {
        this.setQuantity(quantity);
    }
}
