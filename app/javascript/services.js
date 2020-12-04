import newResource from "resource";

function url(...elements) {
  return "/" + elements.join("/");
}

export const Quiz = newResource("/quiz/:id");
export const Category = newResource("/quiz/:quiz_id/category/:id");
export const Question = newResource("/quiz/:quiz_id/category/:category_id/question/:id");
