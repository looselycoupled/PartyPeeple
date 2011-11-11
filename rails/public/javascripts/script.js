(function($){

    function nothingToDo () {
        return { 'init': function() { } };
    }

    window.PP = {

        'headerImage': function(){
            var $h = $('body > header');
            if(!$h.length){
                return nothingToDo();
            }
            var $w = $(window),
                resizeImage = function(evt){
                    $h.add($h.children()).css({
                        'height': $h.width()/1024*690
                    });
                };
            $w.resize(resizeImage).scroll(resizeImage);
            resizeImage();
            return nothingToDo();
        },

        'autoSubmit': function(){
            var $f = $('.currently form');
            if(!$f.length){
                return nothingToDo();
            }
            $f.find('select').change(function(){
                $(this).closest('form').submit();
            });
            return nothingToDo();
        },

        'xc': function(){
            var $xc = $('.xc');
            if(!$xc.length){
                return nothingToDo();
            }
            $xc.each(function(index, element){
                var $e = $(element),
                    $toggler = $e.children('header'),
                    $toToggle = $e.children(':not(header)'),
                    showHide = function(evt){
                        $toToggle.toggle();
                        $toggler.toggleClass('hidden');
                    };
                $toToggle.toggle();
                $toggler.toggleClass('hidden');
                $toggler.click(showHide);
            });
            return nothingToDo();
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