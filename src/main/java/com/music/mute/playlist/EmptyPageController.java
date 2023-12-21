package com.music.mute.playlist;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EmptyPageController {

    @GetMapping("/emptyPage")
    public String emptyPage() {
        return "/emptyPage";
    }
}

