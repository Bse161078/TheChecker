export class Subscriber {
    constructor(x) {
      this.email = x.email;
    }
  
    static fromFirestore(doc) {
      const data = doc.data();
  console.log("data",data)
      if (!data) return null;
  
      return new Subscriber({
       email: data["email"]&&data["email"],
      });
    }
  
    toJson(x) {
      return {
        email: x.email,
      };
    }
  }
  