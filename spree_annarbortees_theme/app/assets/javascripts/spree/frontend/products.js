$( document).ready(function(){
    $('#carousel-product').carousel();
    $('#variantTabs > .nav-tabs a').click(function (e) {
        e.preventDefault()
        $(this).tab('show')
    })
});