import { application } from "./application";

import FollowController from "./follow_controller";
import PreviewController from "./preview_controller";
import ModalController from "./modal_controller";
import ProfileController from "./profile_controller";
import ThemeController from "./theme_controller";
import MainController from "./main_controller";

application.register("follow", FollowController);
application.register("preview", PreviewController);
application.register("modal", ModalController);
application.register("profile", ProfileController);
application.register("theme", ThemeController);
application.register("main", MainController);
