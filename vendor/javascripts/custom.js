
$(function() {

    "use strict";

        /*---------------------------------------------------------------------
        Ripple Effect
        -----------------------------------------------------------------------*/
        $(document).on('click', ".iq-waves-effect", function(e) {
            // Remove any old one
            $('.ripple').remove();
            // Setup
            let posX = $(this).offset().left,
                posY = $(this).offset().top,
                buttonWidth = $(this).width(),
                buttonHeight = $(this).height();

            // Add the element
            $(this).prepend("<span class='ripple'></span>");


            // Make it round!
            if (buttonWidth >= buttonHeight) {
                buttonHeight = buttonWidth;
            } else {
                buttonWidth = buttonHeight;
            }

            // Get the center of the element
            let x = e.pageX - posX - buttonWidth / 2;
            let y = e.pageY - posY - buttonHeight / 2;


            // Add the ripples CSS and start the animation
            $(".ripple").css({
                width: buttonWidth,
                height: buttonHeight,
                top: y + 'px',
                left: x + 'px'
            }).addClass("rippleEffect");
        });

        /*---------------------------------------------------------------------
        Page faq
        -----------------------------------------------------------------------*/
        $('.iq-accordion .iq-accordion-block .accordion-details').hide();
        $('.iq-accordion .iq-accordion-block:first').addClass('accordion-active').children().slideDown('slow');
        $(document).on("click", '.iq-accordion .iq-accordion-block', function() {
            if ($(this).children('div.accordion-details ').is(':hidden')) {
                $('.iq-accordion .iq-accordion-block').removeClass('accordion-active').children('div.accordion-details ').slideUp('slow');
                $(this).toggleClass('accordion-active').children('div.accordion-details ').slideDown('slow');
            }
        });
        
        /*---------------------------------------------------------------------
        Page Loader
        -----------------------------------------------------------------------*/
        $("#load").fadeOut();
        $("#loading").delay().fadeOut("");

        

        /*---------------------------------------------------------------------
       Owl Carousel
       -----------------------------------------------------------------------*/
        $('.owl-carousel').each(function() {
            let $carousel = $(this);
            $carousel.owlCarousel({
                items: $carousel.data("items"),
                loop: $carousel.data("loop"),
                margin: $carousel.data("margin"),
                nav: $carousel.data("nav"),
                dots: $carousel.data("dots"),
                autoplay: $carousel.data("autoplay"),
                autoplayTimeout: $carousel.data("autoplay-timeout"),
                navText: ["<i class='fa fa-angle-left fa-2x'></i>", "<i class='fa fa-angle-right fa-2x'></i>"],
                responsiveClass: true,
                responsive: {
                    // breakpoint from 0 up
                    0: {
                        items: $carousel.data("items-mobile-sm"),
                        nav: false,
                        dots: true
                    },
                    // breakpoint from 480 up
                    480: {
                        items: $carousel.data("items-mobile"),
                        nav: false,
                        dots: true
                    },
                    // breakpoint from 786 up
                    786: {
                        items: $carousel.data("items-tab")
                    },
                    // breakpoint from 1023 up
                    1023: {
                        items: $carousel.data("items-laptop")
                    },
                    1199: {
                        items: $carousel.data("items")
                    }
                }
            });
        });

        /*---------------------------------------------------------------------
        Search input
        -----------------------------------------------------------------------*/
        $(document).on('click', function(e) {
            let myTargetElement = e.target;
            let selector, mainElement;
            if ($(myTargetElement).hasClass('search-toggle') || $(myTargetElement).parent().hasClass('search-toggle') || $(myTargetElement).parent().parent().hasClass('search-toggle')) {
                if ($(myTargetElement).hasClass('search-toggle')) {
                    selector = $(myTargetElement).parent();
                    mainElement = $(myTargetElement);
                } else if ($(myTargetElement).parent().hasClass('search-toggle')) {
                    selector = $(myTargetElement).parent().parent();
                    mainElement = $(myTargetElement).parent();
                } else if ($(myTargetElement).parent().parent().hasClass('search-toggle')) {
                    selector = $(myTargetElement).parent().parent().parent();
                    mainElement = $(myTargetElement).parent().parent();
                }
                if (!mainElement.hasClass('active') && $(".navbar-list li").find('.active')) {
                    $('.navbar-list li').removeClass('iq-show');
                    $('.navbar-list li .search-toggle').removeClass('active');
                }

                selector.toggleClass('iq-show');
                mainElement.toggleClass('active');

                e.preventDefault();
            } else if ($(myTargetElement).is('.search-input')) {} else {
                $('.navbar-list li').removeClass('iq-show');
                $('.navbar-list li .search-toggle').removeClass('active');
            }
        });

        
        /*---------------------------------------------------------------------
        Progress Bar
        -----------------------------------------------------------------------*/
        $('.iq-progress-bar > span').each(function() {
            let progressBar = $(this);
            let width = $(this).data('percent');
            progressBar.css({
                'transition': 'width 2s'
            });

            setTimeout(function() {
                progressBar.appear(function() {
                    progressBar.css('width', width + '%');
                });
            }, 100);
        });


        /*---------------------------------------------------------------------
        Page Menu
        -----------------------------------------------------------------------*/
        $(document).on('click', '.wrapper-menu', function() {
            $(this).toggleClass('open');
        });

        $(document).on('click', ".wrapper-menu", function() {
            $("body").toggleClass("sidebar-main");
        });

        /*---------------------------------------------------------------------
        Mailbox
        -----------------------------------------------------------------------*/
        $(document).on('click', 'ul.iq-email-sender-list li', function() {
            $(this).next().addClass('show');
        });

        $(document).on('click', '.email-app-details li h4', function() {
            $('.email-app-details').removeClass('show');
        });


        /*---------------------------------------------------------------------
        chatuser
        -----------------------------------------------------------------------*/
        $(document).on('click', '.chat-head .chat-user-profile', function() {
            $(this).parent().next().toggleClass('show');
        });
        $(document).on('click', '.user-profile .close-popup', function() {
            $(this).parent().parent().removeClass('show');
        });

        /*---------------------------------------------------------------------
        chatuser main
        -----------------------------------------------------------------------*/
        $(document).on('click', '.chat-search .chat-profile', function() {
            $(this).parent().next().toggleClass('show');
        });
        $(document).on('click', '.user-profile .close-popup', function() {
            $(this).parent().parent().removeClass('show');
        });

        /*---------------------------------------------------------------------
        Chat start
        -----------------------------------------------------------------------*/
        $(document).on('click', '#chat-start', function() {
            $('.chat-data-left').toggleClass('show');
        });
        $(document).on('click', '.close-btn-res', function() {
            $('.chat-data-left').removeClass('show');
        });
        $(document).on('click', '.iq-chat-ui li', function() {
            $('.chat-data-left').removeClass('show');
        });
        $(document).on('click', '.sidebar-toggle', function() {
            $('.chat-data-left').addClass('show');
        });

        /*---------------------------------------------------------------------
        todo Page
        -----------------------------------------------------------------------*/
        $(document).on('click', '.todo-task-list > li > a', function() {
            $('.todo-task-list li').removeClass('active');
            $('.todo-task-list .sub-task').removeClass('show');
            $(this).parent().toggleClass('active');
            $(this).next().toggleClass('show');
        });
        $(document).on('click', '.todo-task-list > li li > a', function() {
            $('.todo-task-list li li').removeClass('active');
            $(this).parent().toggleClass('active');
        });
        /*---------------------------------------------------------------------
        Form Validation
        -----------------------------------------------------------------------*/

        // Example starter JavaScript for disabling form submissions if there are invalid fields
        window.addEventListener('load', function() {
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            var forms = document.getElementsByClassName('needs-validation');
            // Loop over them and prevent submission
            var validation = Array.prototype.filter.call(forms, function(form) {
                form.addEventListener('submit', function(event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);

        /*---------------------------------------------------------------------
        Sidebar Widget
        -----------------------------------------------------------------------*/
        $(document).ready(function() {
            $().on('click', '.todo-task-lists li', function() {
                if ($(this).find('input:checkbox[name=todo-check]').is(":checked")) {

                    $(this).find('input:checkbox[name=todo-check]').attr("checked", false);
                    $(this).removeClass('active-task');
                } else {
                    $(this).find('input:checkbox[name=todo-check]').attr("checked", true);
                    $(this).addClass('active-task');
                }
               
            });
        });

       

        /*------------------------------------------------------------------
        Flatpicker
        * -----------------------------------------------------------------*/
        if (typeof flatpickr !== 'undefined' && $.isFunction(flatpickr)) {
            $(".flatpicker").flatpickr({
                inline: true
            });
        }

});