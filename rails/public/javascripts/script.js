(function($){

    window.PP = {

        'headerImage': function(){
            var $h = $('body > header');
            if(!$h.length){
                return;
            }
            var $w = $(window),
                resizeImage = function(evt){
                    $h.add($h.children()).css({
                        'height': $h.width()/1024*690
                    });
                };
            $w.resize(resizeImage).scroll(resizeImage);
            resizeImage();
            return {};
        },

        'autoSubmit': function(){
            var $f = $('.currently form');
            if(!$f.length){
                return;
            }
            $f.find('select').change(function(){
                $(this).closest('form').submit();
            });
        }
        
    };

    $(document).ready(function(){

        $('html').removeClass('no-js').addClass('js');

        for(var part in PP){
            PP[part] = PP[part]();
            if(!!PP[part].init){
                PP[part].init();
            }
        }

    });

    $(window).load(function(){
        window.scroll(1, 1);
    });


})(jQuery);