import { MDCDrawer } from "@material/drawer";
import { MDCTopAppBar } from "@material/top-app-bar";

const topAppBarSelector = document.querySelector(".mdc-top-app-bar");
const topAppBar = new MDCTopAppBar.attachTo(topAppBarSelector);
const drawerSelector = document.querySelector(".mdc-drawer");
const drawer = new MDCDrawer.attachTo(drawerSelector);
const mainContent = document.querySelector(".service__main-content");

if (mainContent) {
    topAppBar.setScrollTarget(mainContent);

    topAppBar.listen("MDCTopAppBar:nav", () => {
        drawer.open = !drawer.open;
    });
}
