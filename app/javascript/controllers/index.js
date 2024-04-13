import { application } from "./application";

import FollowController from "./follow_controller";
import PreviewController from "./preview_controller";

application.register("follow", FollowController);
application.register("preview", PreviewController);
