package test.java.com.example.app.steps;

import io.cucumber.java.en.*;

public class StepDefinitions {

    @Given("ユーザーがログインページを開いている")
    public void openLoginPage() {
        // 実装
    }

    @When("ユーザーがユーザー名 {string} とパスワード {string} を入力する")
    public void enterCredentials(String user, String pass) {
        // 実装
    }

    @Then("ホームページが表示される")
    public void homepageIsShown() {
        // 実装
    }
}
