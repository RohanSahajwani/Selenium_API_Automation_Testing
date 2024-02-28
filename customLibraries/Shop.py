from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn


@library
class Shop:

    def __init__(self):
        self.selLib = BuiltIn().get_library_instance('SeleniumLibrary')

    @keyword
    def add_items_to_card_and_checkout(self, products_list):
        # Get WebElements
        i = 1
        products_titles = self.selLib.get_webelements('xpath://h4[@class="card-title"]')
        for products_title in products_titles:
            if products_title.text in products_list:
                self.selLib.click_button('xpath:(//button[@class="btn btn-info"])['+str(i)+']')

            i += 1

        self.selLib.click_link('css:li.active a')
