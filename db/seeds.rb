lawrence = User.create(name: "lawrence", username: "lawrence", password: "123")
paul = User.create(name: "paul", username: "paul", password: "123")

gatsby = Book.create(title: "The Great Gatsby", author: "F. Scott Fitzgerald", description: "A true classic of twentieth-century literature, this edition has been updated by Fitzgerald scholar James L.W. West III to include the author’s final revisions and features a note on the composition and text, a personal foreword by Fitzgerald’s granddaughter, Eleanor Lanahan—and a new introduction by two-time National Book Award winner Jesmyn Ward. The Great Gatsby, F. Scott Fitzgerald’s third book, stands as the supreme achievement of his career. First published in 1925, this quintessential novel of the Jazz Age has been acclaimed by generations of readers. The story of the mysteriously wealthy Jay Gatsby and his love for the beautiful Daisy Buchanan, of lavish parties on Long Island at a time when The New York Times noted “gin was the national drink and sex the national obsession,” it is an exquisitely crafted tale of America in the 1920s.", image: "http://books.google.com/books/content?id=iXn5U2IzVH0C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api")

wishlist1 = Shelve.create(name: "Wishlist", user_id: lawrence.id)
wishlist2 = Shelve.create(name: "Wishlist", user_id: paul.id)

shelvebook1 = ShelvesBook.create(shelf_id: wishlist1.id, book_id: gatsby.id)
shelvebook2 = ShelvesBook.create(shelf_id: wishlist2.id, book_id: gatsby.id)
