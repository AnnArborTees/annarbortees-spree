/**
 * bootstrap.js v3.0.0 by @fat and @mdo
 * Copyright 2013 Twitter Inc.
 * http://www.apache.org/licenses/LICENSE-2.0
 */
if (!jQuery) throw new Error("Bootstrap requires jQuery"); + function (a) {
    "use strict";

    function b() {
        var a = document.createElement("bootstrap"),
            b = {
                WebkitTransition: "webkitTransitionEnd",
                MozTransition: "transitionend",
                OTransition: "oTransitionEnd otransitionend",
                transition: "transitionend"
            };
        for (var c in b)
            if (void 0 !== a.style[c]) return {
                end: b[c]
            }
    }
    a.fn.emulateTransitionEnd = function (b) {
        var c = !1,
            d = this;
        a(this).one(a.support.transition.end, function () {
            c = !0
        });
        var e = function () {
            c || a(d).trigger(a.support.transition.end)
        };
        return setTimeout(e, b), this
    }, a(function () {
        a.support.transition = b()
    })
}(window.jQuery), + function (a) {
    "use strict";
    var b = '[data-dismiss="alert"]',
        c = function (c) {
            a(c).on("click", b, this.close)
        };
    c.prototype.close = function (b) {
        function c() {
            f.trigger("closed.bs.alert").remove()
        }
        var d = a(this),
            e = d.attr("data-target");
        e || (e = d.attr("href"), e = e && e.replace(/.*(?=#[^\s]*$)/, ""));
        var f = a(e);
        b && b.preventDefault(), f.length || (f = d.hasClass("alert") ? d : d.parent()), f.trigger(b = a.Event("close.bs.alert")), b.isDefaultPrevented() || (f.removeClass("in"), a.support.transition && f.hasClass("fade") ? f.one(a.support.transition.end, c).emulateTransitionEnd(150) : c())
    };
    var d = a.fn.alert;
    a.fn.alert = function (b) {
        return this.each(function () {
            var d = a(this),
                e = d.data("bs.alert");
            e || d.data("bs.alert", e = new c(this)), "string" == typeof b && e[b].call(d)
        })
    }, a.fn.alert.Constructor = c, a.fn.alert.noConflict = function () {
        return a.fn.alert = d, this
    }, a(document).on("click.bs.alert.data-api", b, c.prototype.close)
}(window.jQuery), + function (a) {
    "use strict";
    var b = function (c, d) {
        this.$element = a(c), this.options = a.extend({}, b.DEFAULTS, d)
    };
    b.DEFAULTS = {
        loadingText: "loading..."
    }, b.prototype.setState = function (a) {
        var b = "disabled",
            c = this.$element,
            d = c.is("input") ? "val" : "html",
            e = c.data();
        a += "Text", e.resetText || c.data("resetText", c[d]()), c[d](e[a] || this.options[a]), setTimeout(function () {
            "loadingText" == a ? c.addClass(b).attr(b, b) : c.removeClass(b).removeAttr(b)
        }, 0)
    }, b.prototype.toggle = function () {
        var a = this.$element.closest('[data-toggle="buttons"]');
        if (a.length) {
            var b = this.$element.find("input").prop("checked", !this.$element.hasClass("active")).trigger("change");
            "radio" === b.prop("type") && a.find(".active").removeClass("active")
        }
        this.$element.toggleClass("active")
    };
    var c = a.fn.button;
    a.fn.button = function (c) {
        return this.each(function () {
            var d = a(this),
                e = d.data("bs.button"),
                f = "object" == typeof c && c;
            e || d.data("bs.button", e = new b(this, f)), "toggle" == c ? e.toggle() : c && e.setState(c)
        })
    }, a.fn.button.Constructor = b, a.fn.button.noConflict = function () {
        return a.fn.button = c, this
    }, a(document).on("click.bs.button.data-api", "[data-toggle^=button]", function (b) {
        var c = a(b.target);
        c.hasClass("btn") || (c = c.closest(".btn")), c.button("toggle"), b.preventDefault()
    })
}(window.jQuery), + function (a) {
    "use strict";
    var b = function (b, c) {
        this.$element = a(b), this.$indicators = this.$element.find(".carousel-indicators"), this.options = c, this.paused = this.sliding = this.interval = this.$active = this.$items = null, "hover" == this.options.pause && this.$element.on("mouseenter", a.proxy(this.pause, this)).on("mouseleave", a.proxy(this.cycle, this))
    };
    b.DEFAULTS = {
        interval: 5e3,
        pause: "hover",
        wrap: !0
    }, b.prototype.cycle = function (b) {
        return b || (this.paused = !1), this.interval && clearInterval(this.interval), this.options.interval && !this.paused && (this.interval = setInterval(a.proxy(this.next, this), this.options.interval)), this
    }, b.prototype.getActiveIndex = function () {
        return this.$active = this.$element.find(".item.active"), this.$items = this.$active.parent().children(), this.$items.index(this.$active)
    }, b.prototype.to = function (b) {
        var c = this,
            d = this.getActiveIndex();
        return b > this.$items.length - 1 || 0 > b ? void 0 : this.sliding ? this.$element.one("slid", function () {
            c.to(b)
        }) : d == b ? this.pause().cycle() : this.slide(b > d ? "next" : "prev", a(this.$items[b]))
    }, b.prototype.pause = function (b) {
        return b || (this.paused = !0), this.$element.find(".next, .prev").length && a.support.transition.end && (this.$element.trigger(a.support.transition.end), this.cycle(!0)), this.interval = clearInterval(this.interval), this
    }, b.prototype.next = function () {
        return this.sliding ? void 0 : this.slide("next")
    }, b.prototype.prev = function () {
        return this.sliding ? void 0 : this.slide("prev")
    }, b.prototype.slide = function (b, c) {
        var d = this.$element.find(".item.active"),
            e = c || d[b](),
            f = this.interval,
            g = "next" == b ? "left" : "right",
            h = "next" == b ? "first" : "last",
            i = this;
        if (!e.length) {
            if (!this.options.wrap) return;
            e = this.$element.find(".item")[h]()
        }
        this.sliding = !0, f && this.pause();
        var j = a.Event("slide.bs.carousel", {
            relatedTarget: e[0],
            direction: g
        });
        if (!e.hasClass("active")) {
            if (this.$indicators.length && (this.$indicators.find(".active").removeClass("active"), this.$element.one("slid", function () {
                var b = a(i.$indicators.children()[i.getActiveIndex()]);
                b && b.addClass("active")
            })), a.support.transition && this.$element.hasClass("slide")) {
                if (this.$element.trigger(j), j.isDefaultPrevented()) return;
                e.addClass(b), e[0].offsetWidth, d.addClass(g), e.addClass(g), d.one(a.support.transition.end, function () {
                    e.removeClass([b, g].join(" ")).addClass("active"), d.removeClass(["active", g].join(" ")), i.sliding = !1, setTimeout(function () {
                        i.$element.trigger("slid")
                    }, 0)
                }).emulateTransitionEnd(600)
            } else {
                if (this.$element.trigger(j), j.isDefaultPrevented()) return;
                d.removeClass("active"), e.addClass("active"), this.sliding = !1, this.$element.trigger("slid")
            }
            return f && this.cycle(), this
        }
    };
    var c = a.fn.carousel;
    a.fn.carousel = function (c) {
        return this.each(function () {
            var d = a(this),
                e = d.data("bs.carousel"),
                f = a.extend({}, b.DEFAULTS, d.data(), "object" == typeof c && c),
                g = "string" == typeof c ? c : f.slide;
            e || d.data("bs.carousel", e = new b(this, f)), "number" == typeof c ? e.to(c) : g ? e[g]() : f.interval && e.pause().cycle()
        })
    }, a.fn.carousel.Constructor = b, a.fn.carousel.noConflict = function () {
        return a.fn.carousel = c, this
    }, a(document).on("click.bs.carousel.data-api", "[data-slide], [data-slide-to]", function (b) {
        var c, d = a(this),
            e = a(d.attr("data-target") || (c = d.attr("href")) && c.replace(/.*(?=#[^\s]+$)/, "")),
            f = a.extend({}, e.data(), d.data()),
            g = d.attr("data-slide-to");
        g && (f.interval = !1), e.carousel(f), (g = d.attr("data-slide-to")) && e.data("bs.carousel").to(g), b.preventDefault()
    }), a(window).on("load", function () {
        a('[data-ride="carousel"]').each(function () {
            var b = a(this);
            b.carousel(b.data())
        })
    })
}(window.jQuery), + function (a) {
    "use strict";
    var b = function (c, d) {
        this.$element = a(c), this.options = a.extend({}, b.DEFAULTS, d), this.transitioning = null, this.options.parent && (this.$parent = a(this.options.parent)), this.options.toggle && this.toggle()
    };
    b.DEFAULTS = {
        toggle: !0
    }, b.prototype.dimension = function () {
        var a = this.$element.hasClass("width");
        return a ? "width" : "height"
    }, b.prototype.show = function () {
        if (!this.transitioning && !this.$element.hasClass("in")) {
            var b = a.Event("show.bs.collapse");
            if (this.$element.trigger(b), !b.isDefaultPrevented()) {
                var c = this.$parent && this.$parent.find("> .panel > .in");
                if (c && c.length) {
                    var d = c.data("bs.collapse");
                    if (d && d.transitioning) return;
                    c.collapse("hide"), d || c.data("bs.collapse", null)
                }
                var e = this.dimension();
                this.$element.removeClass("collapse").addClass("collapsing")[e](0), this.transitioning = 1;
                var f = function () {
                    this.$element.removeClass("collapsing").addClass("in")[e]("auto"), this.transitioning = 0, this.$element.trigger("shown.bs.collapse")
                };
                if (!a.support.transition) return f.call(this);
                var g = a.camelCase(["scroll", e].join("-"));
                this.$element.one(a.support.transition.end, a.proxy(f, this)).emulateTransitionEnd(350)[e](this.$element[0][g])
            }
        }
    }, b.prototype.hide = function () {
        if (!this.transitioning && this.$element.hasClass("in")) {
            var b = a.Event("hide.bs.collapse");
            if (this.$element.trigger(b), !b.isDefaultPrevented()) {
                var c = this.dimension();
                this.$element[c](this.$element[c]())[0].offsetHeight, this.$element.addClass("collapsing").removeClass("collapse").removeClass("in"), this.transitioning = 1;
                var d = function () {
                    this.transitioning = 0, this.$element.trigger("hidden.bs.collapse").removeClass("collapsing").addClass("collapse")
                };
                return a.support.transition ? (this.$element[c](0).one(a.support.transition.end, a.proxy(d, this)).emulateTransitionEnd(350), void 0) : d.call(this)
            }
        }
    }, b.prototype.toggle = function () {
        this[this.$element.hasClass("in") ? "hide" : "show"]()
    };
    var c = a.fn.collapse;
    a.fn.collapse = function (c) {
        return this.each(function () {
            var d = a(this),
                e = d.data("bs.collapse"),
                f = a.extend({}, b.DEFAULTS, d.data(), "object" == typeof c && c);
            e || d.data("bs.collapse", e = new b(this, f)), "string" == typeof c && e[c]()
        })
    }, a.fn.collapse.Constructor = b, a.fn.collapse.noConflict = function () {
        return a.fn.collapse = c, this
    }, a(document).on("click.bs.collapse.data-api", "[data-toggle=collapse]", function (b) {
        var c, d = a(this),
            e = d.attr("data-target") || b.preventDefault() || (c = d.attr("href")) && c.replace(/.*(?=#[^\s]+$)/, ""),
            f = a(e),
            g = f.data("bs.collapse"),
            h = g ? "toggle" : d.data(),
            i = d.attr("data-parent"),
            j = i && a(i);
        g && g.transitioning || (j && j.find('[data-toggle=collapse][data-parent="' + i + '"]').not(d).addClass("collapsed"), d[f.hasClass("in") ? "addClass" : "removeClass"]("collapsed")), f.collapse(h)
    })
}(window.jQuery), + function (a) {
    "use strict";

    function b() {
        a(d).remove(), a(e).each(function (b) {
            var d = c(a(this));
            d.hasClass("open") && (d.trigger(b = a.Event("hide.bs.dropdown")), b.isDefaultPrevented() || d.removeClass("open").trigger("hidden.bs.dropdown"))
        })
    }

    function c(b) {
        var c = b.attr("data-target");
        c || (c = b.attr("href"), c = c && /#/.test(c) && c.replace(/.*(?=#[^\s]*$)/, ""));
        var d = c && a(c);
        return d && d.length ? d : b.parent()
    }
    var d = ".dropdown-backdrop",
        e = "[data-toggle=dropdown]",
        f = function (b) {
            a(b).on("click.bs.dropdown", this.toggle)
        };
    f.prototype.toggle = function (d) {
        var e = a(this);
        if (!e.is(".disabled, :disabled")) {
            var f = c(e),
                g = f.hasClass("open");
            if (b(), !g) {
                if ("ontouchstart" in document.documentElement && !f.closest(".navbar-nav").length && a('<div class="dropdown-backdrop"/>').insertAfter(a(this)).on("click", b), f.trigger(d = a.Event("show.bs.dropdown")), d.isDefaultPrevented()) return;
                f.toggleClass("open").trigger("shown.bs.dropdown"), e.focus()
            }
            return !1
        }
    }, f.prototype.keydown = function (b) {
        if (/(38|40|27)/.test(b.keyCode)) {
            var d = a(this);
            if (b.preventDefault(), b.stopPropagation(), !d.is(".disabled, :disabled")) {
                var f = c(d),
                    g = f.hasClass("open");
                if (!g || g && 27 == b.keyCode) return 27 == b.which && f.find(e).focus(), d.click();
                var h = a("[role=menu] li:not(.divider):visible a", f);
                if (h.length) {
                    var i = h.index(h.filter(":focus"));
                    38 == b.keyCode && i > 0 && i--, 40 == b.keyCode && i < h.length - 1 && i++, ~i || (i = 0), h.eq(i).focus()
                }
            }
        }
    };
    var g = a.fn.dropdown;
    a.fn.dropdown = function (b) {
        return this.each(function () {
            var c = a(this),
                d = c.data("dropdown");
            d || c.data("dropdown", d = new f(this)), "string" == typeof b && d[b].call(c)
        })
    }, a.fn.dropdown.Constructor = f, a.fn.dropdown.noConflict = function () {
        return a.fn.dropdown = g, this
    }, a(document).on("click.bs.dropdown.data-api", b).on("click.bs.dropdown.data-api", ".dropdown form", function (a) {
        a.stopPropagation()
    }).on("click.bs.dropdown.data-api", e, f.prototype.toggle).on("keydown.bs.dropdown.data-api", e + ", [role=menu]", f.prototype.keydown)
}(window.jQuery), + function (a) {
    "use strict";
    var b = function (b, c) {
        this.options = c, this.$element = a(b), this.$backdrop = this.isShown = null, this.options.remote && this.$element.load(this.options.remote)
    };
    b.DEFAULTS = {
        backdrop: !0,
        keyboard: !0,
        show: !0
    }, b.prototype.toggle = function (a) {
        return this[this.isShown ? "hide" : "show"](a)
    }, b.prototype.show = function (b) {
        var c = this,
            d = a.Event("show.bs.modal", {
                relatedTarget: b
            });
        this.$element.trigger(d), this.isShown || d.isDefaultPrevented() || (this.isShown = !0, this.escape(), this.$element.on("click.dismiss.modal", '[data-dismiss="modal"]', a.proxy(this.hide, this)), this.backdrop(function () {
            var d = a.support.transition && c.$element.hasClass("fade");
            c.$element.parent().length || c.$element.appendTo(document.body), c.$element.show(), d && c.$element[0].offsetWidth, c.$element.addClass("in").attr("aria-hidden", !1), c.enforceFocus();
            var e = a.Event("shown.bs.modal", {
                relatedTarget: b
            });
            d ? c.$element.find(".modal-dialog").one(a.support.transition.end, function () {
                c.$element.focus().trigger(e)
            }).emulateTransitionEnd(300) : c.$element.focus().trigger(e)
        }))
    }, b.prototype.hide = function (b) {
        b && b.preventDefault(), b = a.Event("hide.bs.modal"), this.$element.trigger(b), this.isShown && !b.isDefaultPrevented() && (this.isShown = !1, this.escape(), a(document).off("focusin.bs.modal"), this.$element.removeClass("in").attr("aria-hidden", !0).off("click.dismiss.modal"), a.support.transition && this.$element.hasClass("fade") ? this.$element.one(a.support.transition.end, a.proxy(this.hideModal, this)).emulateTransitionEnd(300) : this.hideModal())
    }, b.prototype.enforceFocus = function () {
        a(document).off("focusin.bs.modal").on("focusin.bs.modal", a.proxy(function (a) {
            this.$element[0] === a.target || this.$element.has(a.target).length || this.$element.focus()
        }, this))
    }, b.prototype.escape = function () {
        this.isShown && this.options.keyboard ? this.$element.on("keyup.dismiss.bs.modal", a.proxy(function (a) {
            27 == a.which && this.hide()
        }, this)) : this.isShown || this.$element.off("keyup.dismiss.bs.modal")
    }, b.prototype.hideModal = function () {
        var a = this;
        this.$element.hide(), this.backdrop(function () {
            a.removeBackdrop(), a.$element.trigger("hidden.bs.modal")
        })
    }, b.prototype.removeBackdrop = function () {
        this.$backdrop && this.$backdrop.remove(), this.$backdrop = null
    }, b.prototype.backdrop = function (b) {
        var c = this.$element.hasClass("fade") ? "fade" : "";
        if (this.isShown && this.options.backdrop) {
            var d = a.support.transition && c;
            if (this.$backdrop = a('<div class="modal-backdrop ' + c + '" />').appendTo(document.body), this.$element.on("click.dismiss.modal", a.proxy(function (a) {
                a.target === a.currentTarget && ("static" == this.options.backdrop ? this.$element[0].focus.call(this.$element[0]) : this.hide.call(this))
            }, this)), d && this.$backdrop[0].offsetWidth, this.$backdrop.addClass("in"), !b) return;
            d ? this.$backdrop.one(a.support.transition.end, b).emulateTransitionEnd(150) : b()
        } else !this.isShown && this.$backdrop ? (this.$backdrop.removeClass("in"), a.support.transition && this.$element.hasClass("fade") ? this.$backdrop.one(a.support.transition.end, b).emulateTransitionEnd(150) : b()) : b && b()
    };
    var c = a.fn.modal;
    a.fn.modal = function (c, d) {
        return this.each(function () {
            var e = a(this),
                f = e.data("bs.modal"),
                g = a.extend({}, b.DEFAULTS, e.data(), "object" == typeof c && c);
            f || e.data("bs.modal", f = new b(this, g)), "string" == typeof c ? f[c](d) : g.show && f.show(d)
        })
    }, a.fn.modal.Constructor = b, a.fn.modal.noConflict = function () {
        return a.fn.modal = c, this
    }, a(document).on("click.bs.modal.data-api", '[data-toggle="modal"]', function (b) {
        var c = a(this),
            d = c.attr("href"),
            e = a(c.attr("data-target") || d && d.replace(/.*(?=#[^\s]+$)/, "")),
            f = e.data("modal") ? "toggle" : a.extend({
                remote: !/#/.test(d) && d
            }, e.data(), c.data());
        b.preventDefault(), e.modal(f, this).one("hide", function () {
            c.is(":visible") && c.focus()
        })
    }), a(document).on("show.bs.modal", ".modal", function () {
        a(document.body).addClass("modal-open")
    }).on("hidden.bs.modal", ".modal", function () {
        a(document.body).removeClass("modal-open")
    })
}(window.jQuery), + function (a) {
    "use strict";
    var b = function (a, b) {
        this.type = this.options = this.enabled = this.timeout = this.hoverState = this.$element = null, this.init("tooltip", a, b)
    };
    b.DEFAULTS = {
        animation: !0,
        placement: "top",
        selector: !1,
        template: '<div class="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>',
        trigger: "hover focus",
        title: "",
        delay: 0,
        html: !1,
        container: !1
    }, b.prototype.init = function (b, c, d) {
        this.enabled = !0, this.type = b, this.$element = a(c), this.options = this.getOptions(d);
        for (var e = this.options.trigger.split(" "), f = e.length; f--;) {
            var g = e[f];
            if ("click" == g) this.$element.on("click." + this.type, this.options.selector, a.proxy(this.toggle, this));
            else if ("manual" != g) {
                var h = "hover" == g ? "mouseenter" : "focus",
                    i = "hover" == g ? "mouseleave" : "blur";
                this.$element.on(h + "." + this.type, this.options.selector, a.proxy(this.enter, this)), this.$element.on(i + "." + this.type, this.options.selector, a.proxy(this.leave, this))
            }
        }
        this.options.selector ? this._options = a.extend({}, this.options, {
            trigger: "manual",
            selector: ""
        }) : this.fixTitle()
    }, b.prototype.getDefaults = function () {
        return b.DEFAULTS
    }, b.prototype.getOptions = function (b) {
        return b = a.extend({}, this.getDefaults(), this.$element.data(), b), b.delay && "number" == typeof b.delay && (b.delay = {
            show: b.delay,
            hide: b.delay
        }), b
    }, b.prototype.getDelegateOptions = function () {
        var b = {}, c = this.getDefaults();
        return this._options && a.each(this._options, function (a, d) {
            c[a] != d && (b[a] = d)
        }), b
    }, b.prototype.enter = function (b) {
        var c = b instanceof this.constructor ? b : a(b.currentTarget)[this.type](this.getDelegateOptions()).data("bs." + this.type);
        return clearTimeout(c.timeout), c.hoverState = "in", c.options.delay && c.options.delay.show ? (c.timeout = setTimeout(function () {
            "in" == c.hoverState && c.show()
        }, c.options.delay.show), void 0) : c.show()
    }, b.prototype.leave = function (b) {
        var c = b instanceof this.constructor ? b : a(b.currentTarget)[this.type](this.getDelegateOptions()).data("bs." + this.type);
        return clearTimeout(c.timeout), c.hoverState = "out", c.options.delay && c.options.delay.hide ? (c.timeout = setTimeout(function () {
            "out" == c.hoverState && c.hide()
        }, c.options.delay.hide), void 0) : c.hide()
    }, b.prototype.show = function () {
        var b = a.Event("show.bs." + this.type);
        if (this.hasContent() && this.enabled) {
            if (this.$element.trigger(b), b.isDefaultPrevented()) return;
            var c = this.tip();
            this.setContent(), this.options.animation && c.addClass("fade");
            var d = "function" == typeof this.options.placement ? this.options.placement.call(this, c[0], this.$element[0]) : this.options.placement,
                e = /\s?auto?\s?/i,
                f = e.test(d);
            f && (d = d.replace(e, "") || "top"), c.detach().css({
                top: 0,
                left: 0,
                display: "block"
            }).addClass(d), this.options.container ? c.appendTo(this.options.container) : c.insertAfter(this.$element);
            var g = this.getPosition(),
                h = c[0].offsetWidth,
                i = c[0].offsetHeight;
            if (f) {
                var j = this.$element.parent(),
                    k = d,
                    l = document.documentElement.scrollTop || document.body.scrollTop,
                    m = "body" == this.options.container ? window.innerWidth : j.outerWidth(),
                    n = "body" == this.options.container ? window.innerHeight : j.outerHeight(),
                    o = "body" == this.options.container ? 0 : j.offset().left;
                d = "bottom" == d && g.top + g.height + i - l > n ? "top" : "top" == d && g.top - l - i < 0 ? "bottom" : "right" == d && g.right + h > m ? "left" : "left" == d && g.left - h < o ? "right" : d, c.removeClass(k).addClass(d)
            }
            var p = this.getCalculatedOffset(d, g, h, i);
            this.applyPlacement(p, d), this.$element.trigger("shown.bs." + this.type)
        }
    }, b.prototype.applyPlacement = function (a, b) {
        var c, d = this.tip(),
            e = d[0].offsetWidth,
            f = d[0].offsetHeight,
            g = parseInt(d.css("margin-top"), 10),
            h = parseInt(d.css("margin-left"), 10);
        isNaN(g) && (g = 0), isNaN(h) && (h = 0), a.top = a.top + g, a.left = a.left + h, d.offset(a).addClass("in");
        var i = d[0].offsetWidth,
            j = d[0].offsetHeight;
        if ("top" == b && j != f && (c = !0, a.top = a.top + f - j), /bottom|top/.test(b)) {
            var k = 0;
            a.left < 0 && (k = -2 * a.left, a.left = 0, d.offset(a), i = d[0].offsetWidth, j = d[0].offsetHeight), this.replaceArrow(k - e + i, i, "left")
        } else this.replaceArrow(j - f, j, "top");
        c && d.offset(a)
    }, b.prototype.replaceArrow = function (a, b, c) {
        this.arrow().css(c, a ? 50 * (1 - a / b) + "%" : "")
    }, b.prototype.setContent = function () {
        var a = this.tip(),
            b = this.getTitle();
        a.find(".tooltip-inner")[this.options.html ? "html" : "text"](b), a.removeClass("fade in top bottom left right")
    }, b.prototype.hide = function () {
        function b() {
            "in" != c.hoverState && d.detach()
        }
        var c = this,
            d = this.tip(),
            e = a.Event("hide.bs." + this.type);
        return this.$element.trigger(e), e.isDefaultPrevented() ? void 0 : (d.removeClass("in"), a.support.transition && this.$tip.hasClass("fade") ? d.one(a.support.transition.end, b).emulateTransitionEnd(150) : b(), this.$element.trigger("hidden.bs." + this.type), this)
    }, b.prototype.fixTitle = function () {
        var a = this.$element;
        (a.attr("title") || "string" != typeof a.attr("data-original-title")) && a.attr("data-original-title", a.attr("title") || "").attr("title", "")
    }, b.prototype.hasContent = function () {
        return this.getTitle()
    }, b.prototype.getPosition = function () {
        var b = this.$element[0];
        return a.extend({}, "function" == typeof b.getBoundingClientRect ? b.getBoundingClientRect() : {
            width: b.offsetWidth,
            height: b.offsetHeight
        }, this.$element.offset())
    }, b.prototype.getCalculatedOffset = function (a, b, c, d) {
        return "bottom" == a ? {
            top: b.top + b.height,
            left: b.left + b.width / 2 - c / 2
        } : "top" == a ? {
            top: b.top - d,
            left: b.left + b.width / 2 - c / 2
        } : "left" == a ? {
            top: b.top + b.height / 2 - d / 2,
            left: b.left - c
        } : {
            top: b.top + b.height / 2 - d / 2,
            left: b.left + b.width
        }
    }, b.prototype.getTitle = function () {
        var a, b = this.$element,
            c = this.options;
        return a = b.attr("data-original-title") || ("function" == typeof c.title ? c.title.call(b[0]) : c.title)
    }, b.prototype.tip = function () {
        return this.$tip = this.$tip || a(this.options.template)
    }, b.prototype.arrow = function () {
        return this.$arrow = this.$arrow || this.tip().find(".tooltip-arrow")
    }, b.prototype.validate = function () {
        this.$element[0].parentNode || (this.hide(), this.$element = null, this.options = null)
    }, b.prototype.enable = function () {
        this.enabled = !0
    }, b.prototype.disable = function () {
        this.enabled = !1
    }, b.prototype.toggleEnabled = function () {
        this.enabled = !this.enabled
    }, b.prototype.toggle = function (b) {
        var c = b ? a(b.currentTarget)[this.type](this.getDelegateOptions()).data("bs." + this.type) : this;
        c.tip().hasClass("in") ? c.leave(c) : c.enter(c)
    }, b.prototype.destroy = function () {
        this.hide().$element.off("." + this.type).removeData("bs." + this.type)
    };
    var c = a.fn.tooltip;
    a.fn.tooltip = function (c) {
        return this.each(function () {
            var d = a(this),
                e = d.data("bs.tooltip"),
                f = "object" == typeof c && c;
            e || d.data("bs.tooltip", e = new b(this, f)), "string" == typeof c && e[c]()
        })
    }, a.fn.tooltip.Constructor = b, a.fn.tooltip.noConflict = function () {
        return a.fn.tooltip = c, this
    }
}(window.jQuery), + function (a) {
    "use strict";
    var b = function (a, b) {
        this.init("popover", a, b)
    };
    if (!a.fn.tooltip) throw new Error("Popover requires tooltip.js");
    b.DEFAULTS = a.extend({}, a.fn.tooltip.Constructor.DEFAULTS, {
        placement: "right",
        trigger: "click",
        content: "",
        template: '<div class="popover"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>'
    }), b.prototype = a.extend({}, a.fn.tooltip.Constructor.prototype), b.prototype.constructor = b, b.prototype.getDefaults = function () {
        return b.DEFAULTS
    }, b.prototype.setContent = function () {
        var a = this.tip(),
            b = this.getTitle(),
            c = this.getContent();
        a.find(".popover-title")[this.options.html ? "html" : "text"](b), a.find(".popover-content")[this.options.html ? "html" : "text"](c), a.removeClass("fade top bottom left right in"), a.find(".popover-title").html() || a.find(".popover-title").hide()
    }, b.prototype.hasContent = function () {
        return this.getTitle() || this.getContent()
    }, b.prototype.getContent = function () {
        var a = this.$element,
            b = this.options;
        return a.attr("data-content") || ("function" == typeof b.content ? b.content.call(a[0]) : b.content)
    }, b.prototype.arrow = function () {
        return this.$arrow = this.$arrow || this.tip().find(".arrow")
    }, b.prototype.tip = function () {
        return this.$tip || (this.$tip = a(this.options.template)), this.$tip
    };
    var c = a.fn.popover;
    a.fn.popover = function (c) {
        return this.each(function () {
            var d = a(this),
                e = d.data("bs.popover"),
                f = "object" == typeof c && c;
            e || d.data("bs.popover", e = new b(this, f)), "string" == typeof c && e[c]()
        })
    }, a.fn.popover.Constructor = b, a.fn.popover.noConflict = function () {
        return a.fn.popover = c, this
    }
}(window.jQuery), + function (a) {
    "use strict";

    function b(c, d) {
        var e, f = a.proxy(this.process, this);
        this.$element = a(c).is("body") ? a(window) : a(c), this.$body = a("body"), this.$scrollElement = this.$element.on("scroll.bs.scroll-spy.data-api", f), this.options = a.extend({}, b.DEFAULTS, d), this.selector = (this.options.target || (e = a(c).attr("href")) && e.replace(/.*(?=#[^\s]+$)/, "") || "") + " .nav li > a", this.offsets = a([]), this.targets = a([]), this.activeTarget = null, this.refresh(), this.process()
    }
    b.DEFAULTS = {
        offset: 10
    }, b.prototype.refresh = function () {
        var b = this.$element[0] == window ? "offset" : "position";
        this.offsets = a([]), this.targets = a([]);
        var c = this;
        this.$body.find(this.selector).map(function () {
            var d = a(this),
                e = d.data("target") || d.attr("href"),
                f = /^#\w/.test(e) && a(e);
            return f && f.length && [
                [f[b]().top + (!a.isWindow(c.$scrollElement.get(0)) && c.$scrollElement.scrollTop()), e]
            ] || null
        }).sort(function (a, b) {
            return a[0] - b[0]
        }).each(function () {
            c.offsets.push(this[0]), c.targets.push(this[1])
        })
    }, b.prototype.process = function () {
        var a, b = this.$scrollElement.scrollTop() + this.options.offset,
            c = this.$scrollElement[0].scrollHeight || this.$body[0].scrollHeight,
            d = c - this.$scrollElement.height(),
            e = this.offsets,
            f = this.targets,
            g = this.activeTarget;
        if (b >= d) return g != (a = f.last()[0]) && this.activate(a);
        for (a = e.length; a--;) g != f[a] && b >= e[a] && (!e[a + 1] || b <= e[a + 1]) && this.activate(f[a])
    }, b.prototype.activate = function (b) {
        this.activeTarget = b, a(this.selector).parents(".active").removeClass("active");
        var c = this.selector + '[data-target="' + b + '"],' + this.selector + '[href="' + b + '"]',
            d = a(c).parents("li").addClass("active");
        d.parent(".dropdown-menu").length && (d = d.closest("li.dropdown").addClass("active")), d.trigger("activate")
    };
    var c = a.fn.scrollspy;
    a.fn.scrollspy = function (c) {
        return this.each(function () {
            var d = a(this),
                e = d.data("bs.scrollspy"),
                f = "object" == typeof c && c;
            e || d.data("bs.scrollspy", e = new b(this, f)), "string" == typeof c && e[c]()
        })
    }, a.fn.scrollspy.Constructor = b, a.fn.scrollspy.noConflict = function () {
        return a.fn.scrollspy = c, this
    }, a(window).on("load", function () {
        a('[data-spy="scroll"]').each(function () {
            var b = a(this);
            b.scrollspy(b.data())
        })
    })
}(window.jQuery), + function (a) {
    "use strict";
    var b = function (b) {
        this.element = a(b)
    };
    b.prototype.show = function () {
        var b = this.element,
            c = b.closest("ul:not(.dropdown-menu)"),
            d = b.attr("data-target");
        if (d || (d = b.attr("href"), d = d && d.replace(/.*(?=#[^\s]*$)/, "")), !b.parent("li").hasClass("active")) {
            var e = c.find(".active:last a")[0],
                f = a.Event("show.bs.tab", {
                    relatedTarget: e
                });
            if (b.trigger(f), !f.isDefaultPrevented()) {
                var g = a(d);
                this.activate(b.parent("li"), c), this.activate(g, g.parent(), function () {
                    b.trigger({
                        type: "shown.bs.tab",
                        relatedTarget: e
                    })
                })
            }
        }
    }, b.prototype.activate = function (b, c, d) {
        function e() {
            f.removeClass("active").find("> .dropdown-menu > .active").removeClass("active"), b.addClass("active"), g ? (b[0].offsetWidth, b.addClass("in")) : b.removeClass("fade"), b.parent(".dropdown-menu") && b.closest("li.dropdown").addClass("active"), d && d()
        }
        var f = c.find("> .active"),
            g = d && a.support.transition && f.hasClass("fade");
        g ? f.one(a.support.transition.end, e).emulateTransitionEnd(150) : e(), f.removeClass("in")
    };
    var c = a.fn.tab;
    a.fn.tab = function (c) {
        return this.each(function () {
            var d = a(this),
                e = d.data("bs.tab");
            e || d.data("bs.tab", e = new b(this)), "string" == typeof c && e[c]()
        })
    }, a.fn.tab.Constructor = b, a.fn.tab.noConflict = function () {
        return a.fn.tab = c, this
    }, a(document).on("click.bs.tab.data-api", '[data-toggle="tab"], [data-toggle="pill"]', function (b) {
        b.preventDefault(), a(this).tab("show")
    })
}(window.jQuery), + function (a) {
    "use strict";
    var b = function (c, d) {
        this.options = a.extend({}, b.DEFAULTS, d), this.$window = a(window).on("scroll.bs.affix.data-api", a.proxy(this.checkPosition, this)).on("click.bs.affix.data-api", a.proxy(this.checkPositionWithEventLoop, this)), this.$element = a(c), this.affixed = this.unpin = null, this.checkPosition()
    };
    b.RESET = "affix affix-top affix-bottom", b.DEFAULTS = {
        offset: 0
    }, b.prototype.checkPositionWithEventLoop = function () {
        setTimeout(a.proxy(this.checkPosition, this), 1)
    }, b.prototype.checkPosition = function () {
        if (this.$element.is(":visible")) {
            var c = a(document).height(),
                d = this.$window.scrollTop(),
                e = this.$element.offset(),
                f = this.options.offset,
                g = f.top,
                h = f.bottom;
            "object" != typeof f && (h = g = f), "function" == typeof g && (g = f.top()), "function" == typeof h && (h = f.bottom());
            var i = null != this.unpin && d + this.unpin <= e.top ? !1 : null != h && e.top + this.$element.height() >= c - h ? "bottom" : null != g && g >= d ? "top" : !1;
            this.affixed !== i && (this.unpin && this.$element.css("top", ""), this.affixed = i, this.unpin = "bottom" == i ? e.top - d : null, this.$element.removeClass(b.RESET).addClass("affix" + (i ? "-" + i : "")), "bottom" == i && this.$element.offset({
                top: document.body.offsetHeight - h - this.$element.height()
            }))
        }
    };
    var c = a.fn.affix;
    a.fn.affix = function (c) {
        return this.each(function () {
            var d = a(this),
                e = d.data("bs.affix"),
                f = "object" == typeof c && c;
            e || d.data("bs.affix", e = new b(this, f)), "string" == typeof c && e[c]()
        })
    }, a.fn.affix.Constructor = b, a.fn.affix.noConflict = function () {
        return a.fn.affix = c, this
    }, a(window).on("load", function () {
        a('[data-spy="affix"]').each(function () {
            var b = a(this),
                c = b.data();
            c.offset = c.offset || {}, c.offsetBottom && (c.offset.bottom = c.offsetBottom), c.offsetTop && (c.offset.top = c.offsetTop), b.affix(c)
        })
    })
}(window.jQuery);
/* ===========================================================
 * bootstrap-select.js
 * ========================================================== */
! function (c) {
    var d = function (b, e, a) {
        if (a) {
            a.stopPropagation();
            a.preventDefault()
        }
        this.$element = c(b);
        this.$newElement = null;
        this.button = null;
        this.options = c.extend({}, c.fn.selectpicker.defaults, this.$element.data(), typeof e == "object" && e);
        if (this.options.title == null) {
            this.options.title = this.$element.attr("title")
        }
        this.val = d.prototype.val;
        this.render = d.prototype.render;
        this.refresh = d.prototype.refresh;
        this.selectAll = d.prototype.selectAll;
        this.deselectAll = d.prototype.deselectAll;
        this.init()
    };
    d.prototype = {
        constructor: d,
        init: function (i) {
            if (!this.options.container) {
                this.$element.hide()
            } else {
                this.$element.css("visibility", "hidden")
            }
            this.multiple = this.$element.prop("multiple");
            var e = this.$element.attr("class") !== undefined ? this.$element.attr("class").split(/\s+/) : "";
            var a = this.$element.attr("id");
            this.$element.after(this.createView());
            this.$newElement = this.$element.next(".bootstrap-select");
            if (this.options.container) {
                this.selectPosition()
            }
            this.button = this.$newElement.find("> button");
            if (a !== undefined) {
                var b = this;
                this.button.attr("data-id", a);
                c('label[for="' + a + '"]').click(function () {
                    b.$newElement.find("button[data-id=" + a + "]").focus()
                })
            }
            for (var j = 0; j < e.length; j++) {
                if (e[j] != "selectpicker") {
                    this.$newElement.addClass(e[j])
                }
            }
            if (this.multiple) {
                this.$newElement.addClass("show-tick")
            }
            this.button.addClass(this.options.style);
            this.checkDisabled();
            this.checkTabIndex();
            this.clickListener();
            this.render();
            this.setSize()
        },
        createDropdown: function () {
            var a = "<div class='btn-group bootstrap-select'><button type='button' class='btn dropdown-toggle' data-toggle='dropdown'><span class='filter-option pull-left'></span>&nbsp;<span class='caret'></span></button><ul class='dropdown-menu' role='menu'></ul></div>";
            return c(a)
        },
        createView: function () {
            var b = this.createDropdown();
            var a = this.createLi();
            b.find("ul").append(a);
            return b
        },
        reloadLi: function () {
            this.destroyLi();
            var a = this.createLi();
            this.$newElement.find("ul").append(a)
        },
        destroyLi: function () {
            this.$newElement.find("li").remove()
        },
        createLi: function () {
            var a = this;
            var j = [];
            var b = [];
            var l = "";
            this.$element.find("option").each(function () {
                j.push(c(this).text())
            });
            this.$element.find("option").each(function (t) {
                var s = c(this);
                var u = s.attr("class") !== undefined ? s.attr("class") : "";
                var f = s.text();
                var h = s.data("subtext") !== undefined ? '<small class="text-muted">' + s.data("subtext") + "</small>" : "";
                var r = s.data("icon") !== undefined ? '<i class="' + s.data("icon") + '"></i> ' : "";
                if (s.is(":disabled") || s.parent().is(":disabled")) {
                    r = "<span>" + r + "</span>"
                }
                f = r + '<span class="text">' + f + h + "</span>";
                if (a.options.hideDisabled && (s.is(":disabled") || s.parent().is(":disabled"))) {
                    b.push('<a style="min-height: 0; padding: 0"></a>')
                } else {
                    if (s.parent().is("optgroup") && s.data("divider") != true) {
                        if (s.index() == 0) {
                            var g = s.parent().attr("label");
                            var e = s.parent().data("subtext") !== undefined ? '<small class="text-muted">' + s.parent().data("subtext") + "</small>" : "";
                            var v = s.parent().data("icon") ? '<i class="' + s.parent().data("icon") + '"></i> ' : "";
                            g = v + '<span class="text">' + g + e + "</span>";
                            if (s[0].index != 0) {
                                b.push('<div class="div-contain"><div class="divider"></div></div><dt>' + g + "</dt>" + a.createA(f, "opt " + u))
                            } else {
                                b.push("<dt>" + g + "</dt>" + a.createA(f, "opt " + u))
                            }
                        } else {
                            b.push(a.createA(f, "opt " + u))
                        }
                    } else {
                        if (s.data("divider") == true) {
                            b.push('<div class="div-contain"><div class="divider"></div></div>')
                        } else {
                            if (c(this).data("hidden") == true) {
                                b.push("")
                            } else {
                                b.push(a.createA(f, u))
                            }
                        }
                    }
                }
            });
            if (j.length > 0) {
                for (var k = 0; k < j.length; k++) {
                    var i = this.$element.find("option").eq(k);
                    l += "<li rel=" + k + ">" + b[k] + "</li>"
                }
            }
            if (!this.multiple && this.$element.find("option:selected").length == 0 && !a.options.title) {
                this.$element.find("option").eq(0).prop("selected", true).attr("selected", "selected")
            }
            return c(l)
        },
        createA: function (a, b) {
            return '<a tabindex="0" class="' + b + '">' + a + '<i class="icon-ok check-mark"></i></a>'
        },
        render: function () {
            var a = this;
            this.$element.find("option").each(function (e) {
                a.setDisabled(e, c(this).is(":disabled") || c(this).parent().is(":disabled"));
                a.setSelected(e, c(this).is(":selected"))
            });
            var b = this.$element.find("option:selected").map(function (g, e) {
                var f;
                if (a.options.showSubtext && c(this).attr("data-subtext") && !a.multiple) {
                    f = ' <small class="text-muted">' + c(this).data("subtext") + "</small>"
                } else {
                    f = ""
                } if (c(this).attr("title") != undefined) {
                    return c(this).attr("title")
                } else {
                    return c(this).text() + f
                }
            }).toArray();
            var i = !this.multiple ? b[0] : b.join(", ");
            if (a.multiple && a.options.selectedTextFormat.indexOf("count") > -1) {
                var l = a.options.selectedTextFormat.split(">");
                var j = this.options.hideDisabled ? ":not([disabled])" : "";
                if ((l.length > 1 && b.length > l[1]) || (l.length == 1 && b.length >= 2)) {
                    i = b.length + " of " + this.$element.find('option:not([data-divider="true"]):not([data-hidden="true"])' + j).length + " selected"
                }
            }
            if (!i) {
                i = a.options.title != undefined ? a.options.title : a.options.noneSelectedText
            }
            var k;
            if (this.options.showSubtext && this.$element.find("option:selected").attr("data-subtext")) {
                k = ' <small class="text-muted">' + this.$element.find("option:selected").data("subtext") + "</small>"
            } else {
                k = ""
            }
            a.$newElement.find(".filter-option").html(i + k)
        },
        setSize: function () {
            if (this.options.container) {
                this.$newElement.toggle(this.$element.parent().is(":visible"))
            }
            var u = this;
            var z = this.$newElement.find(".dropdown-menu");
            var s = z.find("li > a");
            var b = this.$newElement.addClass("open").find(".dropdown-menu li > a").outerHeight();
            this.$newElement.removeClass("open");
            var w = z.find("li .divider").outerHeight(true);
            var x = this.$newElement.offset().top;
            var t = this.$newElement.outerHeight();
            var B = parseInt(z.css("padding-top")) + parseInt(z.css("padding-bottom")) + parseInt(z.css("border-top-width")) + parseInt(z.css("border-bottom-width"));
            var A = this.options.hideDisabled ? ":not(.disabled)" : "";
            var y;
            if (this.options.size == "auto") {
                var a = function () {
                    var i = x - c(window).scrollTop();
                    var e = window.innerHeight;
                    var h = B + parseInt(z.css("margin-top")) + parseInt(z.css("margin-bottom")) + 2;
                    var f = e - i - t - h;
                    var g;
                    y = f;
                    if (u.$newElement.hasClass("dropup")) {
                        y = i - h
                    }
                    if ((z.find("li").length + z.find("dt").length) > 3) {
                        g = b * 3 + h - 2
                    } else {
                        g = 0
                    }
                    z.css({
                        "max-height": y + "px",
                        "overflow-y": "auto",
                        "min-height": g + "px"
                    })
                };
                a();
                c(window).resize(a);
                c(window).scroll(a)
            } else {
                if (this.options.size && this.options.size != "auto" && z.find("li" + A).length > this.options.size) {
                    var q = z.find("li" + A + " > *").filter(":not(.div-contain)").slice(0, this.options.size).last().parent().index();
                    var r = z.find("li").slice(0, q + 1).find(".div-contain").length;
                    y = b * this.options.size + r * w + B;
                    z.css({
                        "max-height": y + "px",
                        "overflow-y": "auto"
                    })
                }
            } if (this.options.width == "auto") {
                this.$newElement.find(".dropdown-menu").css("min-width", "0");
                var v = this.$newElement.find(".dropdown-menu").css("width");
                this.$newElement.css("width", v);
                if (this.options.container) {
                    this.$element.css("width", v)
                }
            } else {
                if (this.options.width) {
                    if (this.options.container) {
                        this.$element.css("width", this.options.width);
                        this.$newElement.width(this.$element.outerWidth())
                    } else {
                        this.$newElement.css("width", this.options.width)
                    }
                } else {
                    if (this.options.container) {
                        this.$newElement.width(this.$element.outerWidth())
                    }
                }
            }
        },
        selectPosition: function () {
            var b = c(this.options.container).offset();
            var g = this.$element.offset();
            if (b && g) {
                var a = g.top - b.top;
                var h = g.left - b.left;
                this.$newElement.appendTo(this.options.container);
                this.$newElement.css({
                    position: "absolute",
                    top: a + "px",
                    left: h + "px"
                })
            }
        },
        refresh: function () {
            this.reloadLi();
            this.render();
            this.setSize();
            this.checkDisabled();
            if (this.options.container) {
                this.selectPosition()
            }
        },
        setSelected: function (b, a) {
            if (a) {
                this.$newElement.find("li").eq(b).addClass("selected")
            } else {
                this.$newElement.find("li").eq(b).removeClass("selected")
            }
        },
        setDisabled: function (b, a) {
            if (a) {
                this.$newElement.find("li").eq(b).addClass("disabled").find("a").attr("href", "#").attr("tabindex", -1)
            } else {
                this.$newElement.find("li").eq(b).removeClass("disabled").find("a").removeAttr("href").attr("tabindex", 0)
            }
        },
        isDisabled: function () {
            return this.$element.is(":disabled") || this.$element.attr("readonly")
        },
        checkDisabled: function () {
            if (this.isDisabled()) {
                this.button.addClass("disabled");
                this.button.click(function (a) {
                    a.preventDefault()
                });
                this.button.attr("tabindex", "-1")
            } else {
                if (!this.isDisabled() && this.button.hasClass("disabled")) {
                    this.button.removeClass("disabled");
                    this.button.click(function () {
                        return true
                    });
                    this.button.removeAttr("tabindex")
                }
            }
        },
        checkTabIndex: function () {
            if (this.$element.is("[tabindex]")) {
                var a = this.$element.attr("tabindex");
                this.button.attr("tabindex", a)
            }
        },
        clickListener: function () {
            var a = this;
            c("body").on("touchstart.dropdown", ".dropdown-menu", function (b) {
                b.stopPropagation()
            });
            this.$newElement.on("click", "li a", function (b) {
                var l = c(this).parent().index(),
                    e = c(this).parent(),
                    n = e.parents(".bootstrap-select"),
                    k = a.$element.val();
                if (a.multiple) {
                    b.stopPropagation()
                }
                b.preventDefault();
                if (a.$element.not(":disabled") && !c(this).parent().hasClass("disabled")) {
                    if (!a.multiple) {
                        a.$element.find("option").prop("selected", false);
                        a.$element.find("option").eq(l).prop("selected", true)
                    } else {
                        var m = a.$element.find("option").eq(l).prop("selected");
                        if (m) {
                            a.$element.find("option").eq(l).prop("selected", false)
                        } else {
                            a.$element.find("option").eq(l).prop("selected", true)
                        }
                    }
                    n.find(".filter-option").html(e.text());
                    n.find("button").focus();
                    if (k != a.$element.val()) {
                        a.$element.trigger("change")
                    }
                    a.render()
                }
            });
            this.$newElement.on("click", "li.disabled a, li dt, li .div-contain", function (b) {
                b.preventDefault();
                b.stopPropagation();
                var e = c(this).parent().parents(".bootstrap-select");
                e.find("button").focus()
            });
            this.$element.on("change", function (b) {
                a.render()
            })
        },
        val: function (a) {
            if (a != undefined) {
                this.$element.val(a);
                this.$element.trigger("change");
                return this.$element
            } else {
                return this.$element.val()
            }
        },
        selectAll: function () {
            this.$element.find("option").prop("selected", true).attr("selected", "selected");
            this.render()
        },
        deselectAll: function () {
            this.$element.find("option").prop("selected", false).removeAttr("selected");
            this.render()
        },
        keydown: function (r) {
            var e, s, x, t, v, w, b, A, y;
            e = c(this);
            x = e.parent();
            s = c("[role=menu] li:not(.divider):visible a", x);
            if (!s.length) {
                return
            }
            if (/(38|40)/.test(r.keyCode)) {
                t = s.index(s.filter(":focus"));
                w = s.parent(":not(.disabled)").first().index();
                b = s.parent(":not(.disabled)").last().index();
                v = s.eq(t).parent().nextAll(":not(.disabled)").eq(0).index();
                A = s.eq(t).parent().prevAll(":not(.disabled)").eq(0).index();
                y = s.eq(v).parent().prevAll(":not(.disabled)").eq(0).index();
                if (r.keyCode == 38) {
                    if (t != y && t > A) {
                        t = A
                    }
                    if (t < w) {
                        t = w
                    }
                }
                if (r.keyCode == 40) {
                    if (t != y && t < v) {
                        t = v
                    }
                    if (t > b) {
                        t = b
                    }
                }
                s.eq(t).focus()
            } else {
                var z = {
                    48: "0",
                    49: "1",
                    50: "2",
                    51: "3",
                    52: "4",
                    53: "5",
                    54: "6",
                    55: "7",
                    56: "8",
                    57: "9",
                    59: ";",
                    65: "a",
                    66: "b",
                    67: "c",
                    68: "d",
                    69: "e",
                    70: "f",
                    71: "g",
                    72: "h",
                    73: "i",
                    74: "j",
                    75: "k",
                    76: "l",
                    77: "m",
                    78: "n",
                    79: "o",
                    80: "p",
                    81: "q",
                    82: "r",
                    83: "s",
                    84: "t",
                    85: "u",
                    86: "v",
                    87: "w",
                    88: "x",
                    89: "y",
                    90: "z",
                    96: "0",
                    97: "1",
                    98: "2",
                    99: "3",
                    100: "4",
                    101: "5",
                    102: "6",
                    103: "7",
                    104: "8",
                    105: "9"
                };
                var B = [];
                s.each(function () {
                    if (c(this).parent().is(":not(.disabled)")) {
                        if (c.trim(c(this).text().toLowerCase()).substring(0, 1) == z[r.keyCode]) {
                            B.push(c(this).parent().index())
                        }
                    }
                });
                var u = c(document).data("keycount");
                u++;
                c(document).data("keycount", u);
                var a = c.trim(c(":focus").text().toLowerCase()).substring(0, 1);
                if (a != z[r.keyCode]) {
                    u = 1;
                    c(document).data("keycount", u)
                } else {
                    if (u >= B.length) {
                        c(document).data("keycount", 0)
                    }
                }
                s.eq(B[u - 1]).focus()
            } if (/(13)/.test(r.keyCode)) {
                c(":focus").click();
                x.addClass("open");
                c(document).data("keycount", 0)
            }
        }
    };
    c.fn.selectpicker = function (h, b) {
        var j = arguments;
        var a;
        var i = this.each(function () {
            if (c(this).is("select")) {
                var e = c(this),
                    f = e.data("selectpicker"),
                    o = typeof h == "object" && h;
                if (!f) {
                    e.data("selectpicker", (f = new d(this, o, b)))
                } else {
                    if (o) {
                        for (var n in o) {
                            f.options[n] = o[n]
                        }
                    }
                } if (typeof h == "string") {
                    var g = h;
                    if (f[g] instanceof Function) {
                        [].shift.apply(j);
                        a = f[g].apply(f, j)
                    } else {
                        a = f.options[g]
                    }
                }
            }
        });
        if (a != undefined) {
            return a
        } else {
            return i
        }
    };
    c.fn.selectpicker.defaults = {
        style: null,
        size: "auto",
        title: null,
        selectedTextFormat: "values",
        noneSelectedText: "Nothing selected",
        width: null,
        container: false,
        hideDisabled: false,
        showSubtext: false
    };
    c(document).data("keycount", 0).on("keydown", "[data-toggle=dropdown], [role=menu]", d.prototype.keydown)
}(window.jQuery);
/* ===========================================================
 * bootstrap-rowlink.js
 * ========================================================== */
! function (e) {
    var t = function (t, n) {
        n = e.extend({}, e.fn.rowlink.defaults, n);
        var r = t.nodeName.toLowerCase() == "tr" ? e(t) : e(t).find("tr:has(td)");
        r.each(function () {
            var t = e(this).find(n.target).first();
            if (!t.length) return;
            var r = t.attr("href");
            e(this).find("td").not(".nolink").click(function () {
                window.location = r
            }), e(this).addClass("rowlink"), t.replaceWith(t.html())
        })
    };
    e.fn.rowlink = function (n) {
        return this.each(function () {
            var r = e(this),
                i = r.data("rowlink");
            i || r.data("rowlink", i = new t(this, n))
        })
    }, e.fn.rowlink.defaults = {
        target: "a"
    }, e.fn.rowlink.Constructor = t, e(function () {
        e('[data-provide="rowlink"],[data-provides="rowlink"]').each(function () {
            e(this).rowlink(e(this).data())
        })
    })
}(window.jQuery);
/* ===========================================================
 * bootstrap-inputmask.js j2
 * Based on Masked Input plugin by Josh Bush (digitalbush.com)
 * ===========================================================
 * Copyright 2012 Jasny BV, Netherlands.
 * ========================================================== */
! function (d) {
    var c = (window.orientation !== undefined),
        b = navigator.userAgent.toLowerCase().indexOf("android") > -1;
    var a = function (f, e) {
        if (b) {
            return
        }
        this.$element = d(f);
        this.options = d.extend({}, d.fn.inputmask.defaults, e);
        this.mask = String(e.mask);
        this.init();
        this.listen();
        this.checkVal()
    };
    a.prototype = {
        init: function () {
            var f = this.options.definitions;
            var e = this.mask.length;
            this.tests = [];
            this.partialPosition = this.mask.length;
            this.firstNonMaskPos = null;
            d.each(this.mask.split(""), d.proxy(function (g, h) {
                if (h == "?") {
                    e--;
                    this.partialPosition = g
                } else {
                    if (f[h]) {
                        this.tests.push(new RegExp(f[h]));
                        if (this.firstNonMaskPos === null) {
                            this.firstNonMaskPos = this.tests.length - 1
                        }
                    } else {
                        this.tests.push(null)
                    }
                }
            }, this));
            this.buffer = d.map(this.mask.split(""), d.proxy(function (h, g) {
                if (h != "?") {
                    return f[h] ? this.options.placeholder : h
                }
            }, this));
            this.focusText = this.$element.val();
            this.$element.data("rawMaskFn", d.proxy(function () {
                return d.map(this.buffer, function (h, g) {
                    return this.tests[g] && h != this.options.placeholder ? h : null
                }).join("")
            }, this))
        },
        listen: function () {
            if (this.$element.attr("readonly")) {
                return
            }
            var e = (navigator.userAgent.match(/msie/i) ? "paste" : "input") + ".mask";
            this.$element.on("unmask", d.proxy(this.unmask, this)).on("focus.mask", d.proxy(this.focusEvent, this)).on("blur.mask", d.proxy(this.blurEvent, this)).on("keydown.mask", d.proxy(this.keydownEvent, this)).on("keypress.mask", d.proxy(this.keypressEvent, this)).on(e, d.proxy(this.pasteEvent, this))
        },
        caret: function (g, e) {
            if (this.$element.length === 0) {
                return
            }
            if (typeof g == "number") {
                e = (typeof e == "number") ? e : g;
                return this.$element.each(function () {
                    if (this.setSelectionRange) {
                        this.setSelectionRange(g, e)
                    } else {
                        if (this.createTextRange) {
                            var h = this.createTextRange();
                            h.collapse(true);
                            h.moveEnd("character", e);
                            h.moveStart("character", g);
                            h.select()
                        }
                    }
                })
            } else {
                if (this.$element[0].setSelectionRange) {
                    g = this.$element[0].selectionStart;
                    e = this.$element[0].selectionEnd
                } else {
                    if (document.selection && document.selection.createRange) {
                        var f = document.selection.createRange();
                        g = 0 - f.duplicate().moveStart("character", -100000);
                        e = g + f.text.length
                    }
                }
                return {
                    begin: g,
                    end: e
                }
            }
        },
        seekNext: function (f) {
            var e = this.mask.length;
            while (++f <= e && !this.tests[f]) {}
            return f
        },
        seekPrev: function (e) {
            while (--e >= 0 && !this.tests[e]) {}
            return e
        },
        shiftL: function (k, f) {
            var e = this.mask.length;
            if (k < 0) {
                return
            }
            for (var h = k, g = this.seekNext(f); h < e; h++) {
                if (this.tests[h]) {
                    if (g < e && this.tests[h].test(this.buffer[g])) {
                        this.buffer[h] = this.buffer[g];
                        this.buffer[g] = this.options.placeholder
                    } else {
                        break
                    }
                    g = this.seekNext(g)
                }
            }
            this.writeBuffer();
            this.caret(Math.max(this.firstNonMaskPos, k))
        },
        shiftR: function (l) {
            var e = this.mask.length;
            for (var h = l, k = this.options.placeholder; h < e; h++) {
                if (this.tests[h]) {
                    var f = this.seekNext(h);
                    var g = this.buffer[h];
                    this.buffer[h] = k;
                    if (f < e && this.tests[f].test(g)) {
                        k = g
                    } else {
                        break
                    }
                }
            }
        },
        unmask: function () {
            this.$element.unbind(".mask").removeData("inputmask")
        },
        focusEvent: function () {
            this.focusText = this.$element.val();
            var e = this.mask.length;
            var h = this.checkVal();
            this.writeBuffer();
            var g = this;
            var f = function () {
                if (h == e) {
                    g.caret(0, h)
                } else {
                    g.caret(h)
                }
            };
            if (d.support.msie) {
                f()
            } else {
                setTimeout(f, 0)
            }
        },
        blurEvent: function () {
            this.checkVal();
            if (this.$element.val() != this.focusText) {
                this.$element.trigger("change")
            }
        },
        keydownEvent: function (i) {
            var g = i.which;
            if (g == 8 || g == 46 || (c && g == 127)) {
                var j = this.caret(),
                    h = j.begin,
                    f = j.end;
                if (f - h === 0) {
                    h = g != 46 ? this.seekPrev(h) : (f = this.seekNext(h - 1));
                    f = g == 46 ? this.seekNext(f) : f
                }
                this.clearBuffer(h, f);
                this.shiftL(h, f - 1);
                return false
            } else {
                if (g == 27) {
                    this.$element.val(this.focusText);
                    this.caret(0, this.checkVal());
                    return false
                }
            }
        },
        keypressEvent: function (j) {
            var f = this.mask.length;
            var g = j.which,
                m = this.caret();
            if (j.ctrlKey || j.altKey || j.metaKey || g < 32) {
                return true
            } else {
                if (g) {
                    if (m.end - m.begin !== 0) {
                        this.clearBuffer(m.begin, m.end);
                        this.shiftL(m.begin, m.end - 1)
                    }
                    var i = this.seekNext(m.begin - 1);
                    if (i < f) {
                        var l = String.fromCharCode(g);
                        if (this.tests[i].test(l)) {
                            this.shiftR(i);
                            this.buffer[i] = l;
                            this.writeBuffer();
                            var h = this.seekNext(i);
                            this.caret(h)
                        }
                    }
                    return false
                }
            }
        },
        pasteEvent: function () {
            var e = this;
            setTimeout(function () {
                e.caret(e.checkVal(true))
            }, 0)
        },
        clearBuffer: function (h, f) {
            var e = this.mask.length;
            for (var g = h; g < f && g < e; g++) {
                if (this.tests[g]) {
                    this.buffer[g] = this.options.placeholder
                }
            }
        },
        writeBuffer: function () {
            return this.$element.val(this.buffer.join("")).val()
        },
        checkVal: function (g) {
            var e = this.mask.length;
            var l = this.$element.val();
            var k = -1;
            for (var f = 0, j = 0; f < e; f++) {
                if (this.tests[f]) {
                    this.buffer[f] = this.options.placeholder;
                    while (j++ < l.length) {
                        var h = l.charAt(j - 1);
                        if (this.tests[f].test(h)) {
                            this.buffer[f] = h;
                            k = f;
                            break
                        }
                    }
                    if (j > l.length) {
                        break
                    }
                } else {
                    if (this.buffer[f] == l.charAt(j) && f != this.partialPosition) {
                        j++;
                        k = f
                    }
                }
            }
            if (!g && k + 1 < this.partialPosition) {
                this.$element.val("");
                this.clearBuffer(0, e)
            } else {
                if (g || k + 1 >= this.partialPosition) {
                    this.writeBuffer();
                    if (!g) {
                        this.$element.val(this.$element.val().substring(0, k + 1))
                    }
                }
            }
            return (this.partialPosition ? f : this.firstNonMaskPos)
        }
    };
    d.fn.inputmask = function (e) {
        return this.each(function () {
            var g = d(this),
                f = g.data("inputmask");
            if (!f) {
                g.data("inputmask", (f = new a(this, e)))
            }
        })
    };
    d.fn.inputmask.defaults = {
        mask: "",
        placeholder: "_",
        definitions: {
            "9": "[0-9]",
            a: "[A-Za-z]",
            "?": "[A-Za-z0-9]",
            "*": "."
        }
    };
    d.fn.inputmask.Constructor = a;
    d(document).on("focus.inputmask.data-api", "[data-mask]", function (g) {
        var f = d(this);
        if (f.data("inputmask")) {
            return
        }
        g.preventDefault();
        f.inputmask(f.data())
    })
}(window.jQuery);
/* ===========================================================
 * jQuery Flickr Feed Plugin
 * ========================================================== */
(function (a) {
    a.fn.jflickrfeed = function (d, f) {
        d = a.extend(true, {
            flickrbase: "http://api.flickr.com/services/feeds/",
            feedapi: "photos_public.gne",
            limit: 20,
            qstrings: {
                lang: "en-us",
                format: "json",
                jsoncallback: "?"
            },
            cleanDescription: true,
            useTemplate: true,
            itemTemplate: "",
            itemCallback: function () {}
        }, d);
        var b = d.flickrbase + d.feedapi + "?";
        var e = true;
        for (var c in d.qstrings) {
            if (!e) {
                b += "&"
            }
            b += c + "=" + d.qstrings[c];
            e = false
        }
        return a(this).each(function () {
            var h = a(this);
            var g = this;
            a.getJSON(b, function (i) {
                a.each(i.items, function (m, p) {
                    if (m < d.limit) {
                        if (d.cleanDescription) {
                            var o = /<p>(.*?)<\/p>/g;
                            var j = p.description;
                            if (o.test(j)) {
                                p.description = j.match(o)[2];
                                if (p.description != undefined) {
                                    p.description = p.description.replace("<p>", "").replace("</p>", "")
                                }
                            }
                        }
                        p.image_s = p.media.m.replace("_m", "_s");
                        p.image_t = p.media.m.replace("_m", "_t");
                        p.image_m = p.media.m.replace("_m", "_m");
                        p.image = p.media.m.replace("_m", "");
                        p.image_b = p.media.m.replace("_m", "_b");
                        delete p.media;
                        if (d.useTemplate) {
                            var n = d.itemTemplate;
                            for (var l in p) {
                                var k = new RegExp("{{" + l + "}}", "g");
                                n = n.replace(k, p[l])
                            }
                            h.append(n)
                        }
                        d.itemCallback.call(g, p)
                    }
                });
                if (a.isFunction(f)) {
                    f.call(g, i)
                }
            })
        })
    }
})(jQuery);
/* ==========================================================
 * bootstrap-maxlength.js v1.3.7
 * Copyright (c) 2013 Maurizio Napoleoni;
 * ========================================================== */
(function () {
    (function (e) {
        "use strict";
        e.fn.extend({
            maxlength: function (t, n) {
                function s(e) {
                    var t = e.val(),
                        n = t.match(/\n/g),
                        r = n ? n.length : 0;
                    return e.val().length + r
                }

                function o(e, n, r) {
                    var i = !0;
                    return !t.alwaysShow && r - s(e) > n && (i = !1), i
                }

                function u(e, t) {
                    var n = t - s(e);
                    return n
                }

                function a(e) {
                    e.css({
                        display: "block"
                    })
                }

                function f(e) {
                    e.css({
                        display: "none"
                    })
                }

                function l(e, n) {
                    var r = "";
                    return t.preText && (r += t.preText), t.showMaxLength ? r = r + n + t.separator + e : r += n, t.postText && (r += t.postText), r
                }

                function c(e, n, r, i) {
                    i.html(l(r, e)), e > 0 ? o(n, t.threshold, r) ? a(i.removeClass(t.limitReachedClass).addClass(t.warningClass)) : f(i) : a(i.removeClass(t.warningClass).addClass(t.limitReachedClass))
                }

                function h(t) {
                    var n = t[0];
                    return e.extend({}, typeof n.getBoundingClientRect == "function" ? n.getBoundingClientRect() : {
                        width: n.offsetWidth,
                        height: n.offsetHeight
                    }, t.offset())
                }

                function p(e, n) {
                    var r = h(e),
                        i = e.outerWidth(),
                        s = n.outerWidth(),
                        o = n.width(),
                        u = n.height();
                    switch (t.placement) {
                        case "bottom":
                            n.css({
                                top: r.top + r.height,
                                left: r.left + r.width / 2 - o / 2
                            });
                            break;
                        case "top":
                            n.css({
                                top: r.top - u,
                                left: r.left + r.width / 2 - o / 2
                            });
                            break;
                        case "left":
                            n.css({
                                top: r.top + r.height / 2 - u / 2,
                                left: r.left - o
                            });
                            break;
                        case "right":
                            n.css({
                                top: r.top + r.height / 2 - u / 2,
                                left: r.left + r.width
                            });
                            break;
                        case "bottom-right":
                            n.css({
                                top: r.top + r.height,
                                left: r.left + r.width
                            });
                            break;
                        case "top-right":
                            n.css({
                                top: r.top - u,
                                left: r.left + i
                            });
                            break;
                        case "top-left":
                            n.css({
                                top: r.top - u,
                                left: r.left - s
                            });
                            break;
                        case "bottom-left":
                            n.css({
                                top: r.top + e.outerHeight(),
                                left: r.left - s
                            });
                            break;
                        case "centered-right":
                            n.css({
                                top: r.top + u / 2,
                                left: r.left + i - s - 3
                            })
                    }
                }

                function d(e) {
                    return e.attr("maxlength") || e.attr("size")
                }
                var r = e("body"),
                    i = {
                        alwaysShow: !1,
                        threshold: 10,
                        warningClass: "badge badge-success",
                        limitReachedClass: "badge badge-important",
                        separator: " / ",
                        preText: "",
                        postText: "",
                        showMaxLength: !0,
                        placement: "bottom",
                        validate: !1
                    };
                return e.isFunction(t) && !n && (n = t, t = {}), t = e.extend(i, t), this.each(function () {
                    var n = e(this),
                        i = d(n),
                        s = e("<span></span>").css({
                            display: "none",
                            position: "absolute",
                            whiteSpace: "nowrap",
                            zIndex: 999
                        }).html(l(i, "0"));
                    n.is("textarea") && (n.data("maxlenghtsizex", n.outerWidth()), n.data("maxlenghtsizey", n.outerHeight()), n.mouseup(function () {
                        (n.outerWidth() !== n.data("maxlenghtsizex") || n.outerHeight() !== n.data("maxlenghtsizey")) && p(n, s), n.data("maxlenghtsizex", n.outerWidth()), n.data("maxlenghtsizey", n.outerHeight())
                    })), r.append(s), n.focus(function () {
                        var e = u(n, d(n));
                        c(e, n, i, s), p(n, s)
                    }), n.blur(function () {
                        s.css("display", "none")
                    }), n.keyup(function () {
                        var e = u(n, d(n)),
                            r = !0;
                        return t.validate && e < 0 ? r = !1 : c(e, n, i, s), r
                    }), n.keydown(function (e) {
                        var t = u(n, d(n));
                        if (t <= 0 && e.keyCode !== 46 && e.keyCode !== 8) return !1
                    })
                })
            }
        })
    })(jQuery)
}).call(this);
/* ===========================================================
 * Bootstrap Color Picker Plugin
 * =========================================================== */
! function (h) {
    var g = function (a) {
        this.value = {
            h: 1,
            s: 1,
            b: 1,
            a: 1
        };
        this.setColor(a)
    };
    g.prototype = {
        constructor: g,
        setColor: function (a) {
            a = a.toLowerCase();
            var b = this;
            h.each(e.stringParsers, function (i, c) {
                var m = c.re.exec(a),
                    n = m && c.parse(m),
                    d = c.space || "rgba";
                if (n) {
                    if (d === "hsla") {
                        b.value = e.RGBtoHSB.apply(null, e.HSLtoRGB.apply(null, n))
                    } else {
                        b.value = e.RGBtoHSB.apply(null, n)
                    }
                    return false
                }
            })
        },
        setHue: function (a) {
            this.value.h = 1 - a
        },
        setSaturation: function (a) {
            this.value.s = a
        },
        setLightness: function (a) {
            this.value.b = 1 - a
        },
        setAlpha: function (a) {
            this.value.a = parseInt((1 - a) * 100, 10) / 100
        },
        toRGB: function (o, a, d, c) {
            if (!o) {
                o = this.value.h;
                a = this.value.s;
                d = this.value.b
            }
            o *= 360;
            var p, b, r, q, s;
            o = (o % 360) / 60;
            s = d * a;
            q = s * (1 - Math.abs(o % 2 - 1));
            p = b = r = d - s;
            o = ~~o;
            p += [s, q, 0, 0, q, s][o];
            b += [q, s, s, q, 0, 0][o];
            r += [0, 0, q, s, s, q][o];
            return {
                r: Math.round(p * 255),
                g: Math.round(b * 255),
                b: Math.round(r * 255),
                a: c || this.value.a
            }
        },
        toHex: function (a, b, k, d) {
            var c = this.toRGB(a, b, k, d);
            return "#" + ((1 << 24) | (parseInt(c.r) << 16) | (parseInt(c.g) << 8) | parseInt(c.b)).toString(16).substr(1)
        },
        toHSL: function (a, b, n, m) {
            if (!a) {
                a = this.value.h;
                b = this.value.s;
                n = this.value.b
            }
            var c = a,
                o = (2 - b) * n,
                d = b * n;
            if (o > 0 && o <= 1) {
                d /= o
            } else {
                d /= 2 - o
            }
            o /= 2;
            if (d > 1) {
                d = 1
            }
            return {
                h: c,
                s: d,
                l: o,
                a: m || this.value.a
            }
        }
    };
    var f = function (b, c) {
        this.element = h(b);
        var a = c.format || this.element.data("color-format") || "hex";
        this.format = e.translateFormats[a];
        this.isInput = this.element.is("input");
        this.component = this.element.is(".color") ? this.element.find(".input-group-addon") : false;
        this.picker = h(e.template).appendTo("body").on("mousedown", h.proxy(this.mousedown, this));
        if (this.isInput) {
            this.element.on({
                focus: h.proxy(this.show, this),
                keyup: h.proxy(this.update, this)
            })
        } else {
            if (this.component) {
                this.component.on({
                    click: h.proxy(this.show, this)
                })
            } else {
                this.element.on({
                    click: h.proxy(this.show, this)
                })
            }
        } if (a === "rgba" || a === "hsla") {
            this.picker.addClass("alpha");
            this.alpha = this.picker.find(".colorpicker-alpha")[0].style
        }
        if (this.component) {
            this.picker.find(".colorpicker-color").hide();
            this.preview = this.element.find("i")[0].style
        } else {
            this.preview = this.picker.find("div:last")[0].style
        }
        this.base = this.picker.find("div:first")[0].style;
        this.update()
    };
    f.prototype = {
        constructor: f,
        show: function (a) {
            this.picker.show();
            this.height = this.component ? this.component.outerHeight() : this.element.outerHeight();
            this.place();
            h(window).on("resize", h.proxy(this.place, this));
            if (!this.isInput) {
                if (a) {
                    a.stopPropagation();
                    a.preventDefault()
                }
            }
            h(document).on({
                mousedown: h.proxy(this.hide, this)
            });
            this.element.trigger({
                type: "show",
                color: this.color
            })
        },
        update: function () {
            this.color = new g(this.isInput ? this.element.prop("value") : this.element.data("color"));
            this.picker.find("i").eq(0).css({
                left: this.color.value.s * 100,
                top: 100 - this.color.value.b * 100
            }).end().eq(1).css("top", 100 * (1 - this.color.value.h)).end().eq(2).css("top", 100 * (1 - this.color.value.a));
            this.previewColor()
        },
        setValue: function (a) {
            this.color = new g(a);
            this.picker.find("i").eq(0).css({
                left: this.color.value.s * 100,
                top: 100 - this.color.value.b * 100
            }).end().eq(1).css("top", 100 * (1 - this.color.value.h)).end().eq(2).css("top", 100 * (1 - this.color.value.a));
            this.previewColor();
            this.element.trigger({
                type: "changeColor",
                color: this.color
            })
        },
        hide: function () {
            this.picker.hide();
            h(window).off("resize", this.place);
            if (!this.isInput) {
                h(document).off({
                    mousedown: this.hide
                });
                if (this.component) {
                    this.element.find("input").prop("value", this.format.call(this))
                }
                this.element.data("color", this.format.call(this))
            } else {
                this.element.prop("value", this.format.call(this))
            }
            this.element.trigger({
                type: "hide",
                color: this.color
            })
        },
        place: function () {
            var a = this.component ? this.component.offset() : this.element.offset();
            this.picker.css({
                top: a.top + this.height,
                left: a.left
            })
        },
        previewColor: function () {
            try {
                this.preview.backgroundColor = this.format.call(this)
            } catch (a) {
                this.preview.backgroundColor = this.color.toHex()
            }
            this.base.backgroundColor = this.color.toHex(this.color.value.h, 1, 1, 1);
            if (this.alpha) {
                this.alpha.backgroundColor = this.color.toHex()
            }
        },
        pointer: null,
        slider: null,
        mousedown: function (b) {
            b.stopPropagation();
            b.preventDefault();
            var c = h(b.target);
            var d = c.closest("div");
            if (!d.is(".colorpicker")) {
                if (d.is(".colorpicker-saturation")) {
                    this.slider = h.extend({}, e.sliders.saturation)
                } else {
                    if (d.is(".colorpicker-hue")) {
                        this.slider = h.extend({}, e.sliders.hue)
                    } else {
                        if (d.is(".colorpicker-alpha")) {
                            this.slider = h.extend({}, e.sliders.alpha)
                        } else {
                            return false
                        }
                    }
                }
                var a = d.offset();
                this.slider.knob = d.find("i")[0].style;
                this.slider.left = b.pageX - a.left;
                this.slider.top = b.pageY - a.top;
                this.pointer = {
                    left: b.pageX,
                    top: b.pageY
                };
                h(document).on({
                    mousemove: h.proxy(this.mousemove, this),
                    mouseup: h.proxy(this.mouseup, this)
                }).trigger("mousemove")
            }
            return false
        },
        mousemove: function (a) {
            a.stopPropagation();
            a.preventDefault();
            var b = Math.max(0, Math.min(this.slider.maxLeft, this.slider.left + ((a.pageX || this.pointer.left) - this.pointer.left)));
            var c = Math.max(0, Math.min(this.slider.maxTop, this.slider.top + ((a.pageY || this.pointer.top) - this.pointer.top)));
            this.slider.knob.left = b + "px";
            this.slider.knob.top = c + "px";
            if (this.slider.callLeft) {
                this.color[this.slider.callLeft].call(this.color, b / 100)
            }
            if (this.slider.callTop) {
                this.color[this.slider.callTop].call(this.color, c / 100)
            }
            this.previewColor();
            this.element.trigger({
                type: "changeColor",
                color: this.color
            });
            return false
        },
        mouseup: function (a) {
            a.stopPropagation();
            a.preventDefault();
            h(document).off({
                mousemove: this.mousemove,
                mouseup: this.mouseup
            });
            return false
        }
    };
    h.fn.colorpicker = function (b, a) {
        return this.each(function () {
            var c = h(this),
                d = c.data("colorpicker"),
                j = typeof b === "object" && b;
            if (!d) {
                c.data("colorpicker", (d = new f(this, h.extend({}, h.fn.colorpicker.defaults, j))))
            }
            if (typeof b === "string") {
                d[b](a)
            }
        })
    };
    h.fn.colorpicker.defaults = {};
    h.fn.colorpicker.Constructor = f;
    var e = {
        translateFormats: {
            rgb: function () {
                var a = this.color.toRGB();
                return "rgb(" + a.r + "," + a.g + "," + a.b + ")"
            },
            rgba: function () {
                var a = this.color.toRGB();
                return "rgba(" + a.r + "," + a.g + "," + a.b + "," + a.a + ")"
            },
            hsl: function () {
                var a = this.color.toHSL();
                return "hsl(" + Math.round(a.h * 360) + "," + Math.round(a.s * 100) + "%," + Math.round(a.l * 100) + "%)"
            },
            hsla: function () {
                var a = this.color.toHSL();
                return "hsla(" + Math.round(a.h * 360) + "," + Math.round(a.s * 100) + "%," + Math.round(a.l * 100) + "%," + a.a + ")"
            },
            hex: function () {
                return this.color.toHex()
            }
        },
        sliders: {
            saturation: {
                maxLeft: 100,
                maxTop: 100,
                callLeft: "setSaturation",
                callTop: "setLightness"
            },
            hue: {
                maxLeft: 0,
                maxTop: 100,
                callLeft: false,
                callTop: "setHue"
            },
            alpha: {
                maxLeft: 0,
                maxTop: 100,
                callLeft: false,
                callTop: "setAlpha"
            }
        },
        RGBtoHSB: function (b, c, q, o) {
            b /= 255;
            c /= 255;
            q /= 255;
            var d, n, p, a;
            p = Math.max(b, c, q);
            a = p - Math.min(b, c, q);
            d = (a === 0 ? null : p == b ? (c - q) / a : p == c ? (q - b) / a + 2 : (b - c) / a + 4);
            d = ((d + 360) % 6) * 60 / 360;
            n = a === 0 ? 0 : a / p;
            return {
                h: d || 1,
                s: n,
                b: p,
                a: o || 1
            }
        },
        HueToRGB: function (a, b, c) {
            if (c < 0) {
                c += 1
            } else {
                if (c > 1) {
                    c -= 1
                }
            } if ((c * 6) < 1) {
                return a + (b - a) * c * 6
            } else {
                if ((c * 2) < 1) {
                    return b
                } else {
                    if ((c * 3) < 2) {
                        return a + (b - a) * ((2 / 3) - c) * 6
                    } else {
                        return a
                    }
                }
            }
        },
        HSLtoRGB: function (b, s, d, x) {
            if (s < 0) {
                s = 0
            }
            var q;
            if (d <= 0.5) {
                q = d * (1 + s)
            } else {
                q = d + s - (d * s)
            }
            var p = 2 * d - q;
            var z = b + (1 / 3);
            var l = b;
            var c = b - (1 / 3);
            var r = Math.round(e.HueToRGB(p, q, z) * 255);
            var a = Math.round(e.HueToRGB(p, q, l) * 255);
            var y = Math.round(e.HueToRGB(p, q, c) * 255);
            return [r, a, y, x || 1]
        },
        stringParsers: [{
            re: /rgba?\(\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d{1,3})\s*(?:,\s*(\d+(?:\.\d+)?)\s*)?\)/,
            parse: function (a) {
                return [a[1], a[2], a[3], a[4]]
            }
        }, {
            re: /rgba?\(\s*(\d+(?:\.\d+)?)\%\s*,\s*(\d+(?:\.\d+)?)\%\s*,\s*(\d+(?:\.\d+)?)\%\s*(?:,\s*(\d+(?:\.\d+)?)\s*)?\)/,
            parse: function (a) {
                return [2.55 * a[1], 2.55 * a[2], 2.55 * a[3], a[4]]
            }
        }, {
            re: /#([a-fA-F0-9]{2})([a-fA-F0-9]{2})([a-fA-F0-9]{2})/,
            parse: function (a) {
                return [parseInt(a[1], 16), parseInt(a[2], 16), parseInt(a[3], 16)]
            }
        }, {
            re: /#([a-fA-F0-9])([a-fA-F0-9])([a-fA-F0-9])/,
            parse: function (a) {
                return [parseInt(a[1] + a[1], 16), parseInt(a[2] + a[2], 16), parseInt(a[3] + a[3], 16)]
            }
        }, {
            re: /hsla?\(\s*(\d+(?:\.\d+)?)\s*,\s*(\d+(?:\.\d+)?)\%\s*,\s*(\d+(?:\.\d+)?)\%\s*(?:,\s*(\d+(?:\.\d+)?)\s*)?\)/,
            space: "hsla",
            parse: function (a) {
                return [a[1] / 360, a[2] / 100, a[3] / 100, a[4]]
            }
        }],
        template: '<div class="colorpicker dropdown-menu"><div class="colorpicker-saturation"><i><b></b></i></div><div class="colorpicker-hue"><i></i></div><div class="colorpicker-alpha"><i></i></div><div class="colorpicker-color"><div /></div></div>'
    }
}(window.jQuery);
/* ===========================================================
 * Bootstrap Date Picker Plugin
 * =========================================================== */
! function (f) {
    var e = function (a, b) {
        this.element = f(a);
        this.format = d.parseFormat(b.format || this.element.data("date-format") || "mm/dd/yyyy");
        this.picker = f(d.template).appendTo("body").on({
            click: f.proxy(this.click, this)
        });
        this.isInput = this.element.is("input");
        this.component = this.element.is(".date") ? this.element.find(".input-group-addon") : false;
        if (this.isInput) {
            this.element.on({
                focus: f.proxy(this.show, this),
                keyup: f.proxy(this.update, this)
            })
        } else {
            if (this.component) {
                this.component.on("click", f.proxy(this.show, this))
            } else {
                this.element.on("click", f.proxy(this.show, this))
            }
        }
        this.minViewMode = b.minViewMode || this.element.data("date-minviewmode") || 0;
        if (typeof this.minViewMode === "string") {
            switch (this.minViewMode) {
                case "months":
                    this.minViewMode = 1;
                    break;
                case "years":
                    this.minViewMode = 2;
                    break;
                default:
                    this.minViewMode = 0;
                    break
            }
        }
        this.viewMode = b.viewMode || this.element.data("date-viewmode") || 0;
        if (typeof this.viewMode === "string") {
            switch (this.viewMode) {
                case "months":
                    this.viewMode = 1;
                    break;
                case "years":
                    this.viewMode = 2;
                    break;
                default:
                    this.viewMode = 0;
                    break
            }
        }
        this.startViewMode = this.viewMode;
        this.weekStart = b.weekStart || this.element.data("date-weekstart") || 0;
        this.weekEnd = this.weekStart === 0 ? 6 : this.weekStart - 1;
        this.onRender = b.onRender;
        this.fillDow();
        this.fillMonths();
        this.update();
        this.showMode()
    };
    e.prototype = {
        constructor: e,
        show: function (a) {
            this.picker.show();
            this.height = this.component ? this.component.outerHeight() : this.element.outerHeight();
            this.place();
            f(window).on("resize", f.proxy(this.place, this));
            if (a) {
                a.stopPropagation();
                a.preventDefault()
            }
            if (!this.isInput) {}
            var b = this;
            f(document).on("mousedown", function (c) {
                if (f(c.target).closest(".datepicker").length == 0) {
                    b.hide()
                }
            });
            this.element.trigger({
                type: "show",
                date: this.date
            })
        },
        hide: function () {
            this.picker.hide();
            f(window).off("resize", this.place);
            this.viewMode = this.startViewMode;
            this.showMode();
            if (!this.isInput) {
                f(document).off("mousedown", this.hide)
            }
            this.set();
            this.element.trigger({
                type: "hide",
                date: this.date
            })
        },
        set: function () {
            var a = d.formatDate(this.date, this.format);
            if (!this.isInput) {
                if (this.component) {
                    this.element.find("input").prop("value", a)
                }
                this.element.data("date", a)
            } else {
                this.element.prop("value", a)
            }
        },
        setValue: function (a) {
            if (typeof a === "string") {
                this.date = d.parseDate(a, this.format)
            } else {
                this.date = new Date(a)
            }
            this.set();
            this.viewDate = new Date(this.date.getFullYear(), this.date.getMonth(), 1, 0, 0, 0, 0);
            this.fill()
        },
        place: function () {
            var a = this.component ? this.component.offset() : this.element.offset(),
                b = a.top + this.height,
                c = b + 10;
            this.picker.css({
                top: c,
                left: a.left,
                display: "block",
                opacity: 0
            });
            this.picker.animate({
                top: a.top + this.height,
                opacity: 1
            })
        },
        update: function (a) {
            this.date = d.parseDate(typeof a === "string" ? a : (this.isInput ? this.element.prop("value") : this.element.data("date")), this.format);
            this.viewDate = new Date(this.date.getFullYear(), this.date.getMonth(), 1, 0, 0, 0, 0);
            this.fill()
        },
        fillDow: function () {
            var b = this.weekStart;
            var a = "<tr>";
            while (b < this.weekStart + 7) {
                a += '<th class="dow">' + d.dates.daysMin[(b++) % 7] + "</th>"
            }
            a += "</tr>";
            this.picker.find(".datepicker-days thead").append(a)
        },
        fillMonths: function () {
            var a = "";
            var b = 0;
            while (b < 12) {
                a += '<span class="month">' + d.dates.monthsShort[b++] + "</span>"
            }
            this.picker.find(".datepicker-months td").append(a)
        },
        fill: function () {
            var c = new Date(this.viewDate),
                b = c.getFullYear(),
                i = c.getMonth(),
                x = this.date.valueOf();
            this.picker.find(".datepicker-days th:eq(1)").text(d.dates.months[i] + " " + b);
            var u = new Date(b, i - 1, 28, 0, 0, 0, 0),
                a = d.getDaysInMonth(u.getFullYear(), u.getMonth());
            u.setDate(a);
            u.setDate(a - (u.getDay() - this.weekStart + 7) % 7);
            var s = new Date(u);
            s.setDate(s.getDate() + 42);
            s = s.valueOf();
            html = [];
            var v;
            while (u.valueOf() < s) {
                if (u.getDay() === this.weekStart) {
                    html.push("<tr>")
                }
                v = this.onRender(u);
                if (u.getMonth() < i) {
                    v += " old"
                } else {
                    if (u.getMonth() > i) {
                        v += " new"
                    }
                } if (u.valueOf() === x) {
                    v += " active"
                }
                html.push('<td class="day ' + v + '">' + u.getDate() + "</td>");
                if (u.getDay() === this.weekEnd) {
                    html.push("</tr>")
                }
                u.setDate(u.getDate() + 1)
            }
            this.picker.find(".datepicker-days tbody").empty().append(html.join(""));
            var r = this.date.getFullYear();
            var y = this.picker.find(".datepicker-months").find("th:eq(1)").text(b).end().find("span").removeClass("active");
            if (r === b) {
                y.eq(this.date.getMonth()).addClass("active")
            }
            html = "";
            b = parseInt(b / 10, 10) * 10;
            var w = this.picker.find(".datepicker-years").find("th:eq(1)").text(b + "-" + (b + 9)).end().find("td");
            b -= 1;
            for (var t = -1; t < 11; t++) {
                html += '<span class="year' + (t === -1 || t === 10 ? " old" : "") + (r === b ? " active" : "") + '">' + b + "</span>";
                b += 1
            }
            w.html(html)
        },
        click: function (a) {
            a.stopPropagation();
            a.preventDefault();
            var b = f(a.target).closest("span, td, th");
            if (b.length === 1) {
                switch (b[0].nodeName.toLowerCase()) {
                    case "th":
                        switch (b[0].className) {
                            case "switch":
                                this.showMode(1);
                                break;
                            case "prev":
                            case "next":
                                this.viewDate["set" + d.modes[this.viewMode].navFnc].call(this.viewDate, this.viewDate["get" + d.modes[this.viewMode].navFnc].call(this.viewDate) + d.modes[this.viewMode].navStep * (b[0].className === "prev" ? -1 : 1));
                                this.fill();
                                this.set();
                                break
                        }
                        break;
                    case "span":
                        if (b.is(".month")) {
                            var c = b.parent().find("span").index(b);
                            this.viewDate.setMonth(c)
                        } else {
                            var j = parseInt(b.text(), 10) || 0;
                            this.viewDate.setFullYear(j)
                        } if (this.viewMode !== 0) {
                        this.date = new Date(this.viewDate);
                        this.element.trigger({
                            type: "changeDate",
                            date: this.date,
                            viewMode: d.modes[this.viewMode].clsName
                        })
                    }
                        this.showMode(-1);
                        this.fill();
                        this.set();
                        break;
                    case "td":
                        if (b.is(".day") && !b.is(".disabled")) {
                            var k = parseInt(b.text(), 10) || 1;
                            var c = this.viewDate.getMonth();
                            if (b.is(".old")) {
                                c -= 1
                            } else {
                                if (b.is(".new")) {
                                    c += 1
                                }
                            }
                            var j = this.viewDate.getFullYear();
                            this.date = new Date(j, c, k, 0, 0, 0, 0);
                            this.viewDate = new Date(j, c, Math.min(28, k), 0, 0, 0, 0);
                            this.fill();
                            this.set();
                            this.element.trigger({
                                type: "changeDate",
                                date: this.date,
                                viewMode: d.modes[this.viewMode].clsName
                            })
                        }
                        break
                }
            }
        },
        mousedown: function (a) {
            a.stopPropagation();
            a.preventDefault()
        },
        showMode: function (a) {
            if (a) {
                this.viewMode = Math.max(this.minViewMode, Math.min(2, this.viewMode + a))
            }
            this.picker.find(">div").hide().filter(".datepicker-" + d.modes[this.viewMode].clsName).show()
        }
    };
    f.fn.datepicker = function (b, a) {
        return this.each(function () {
            var c = f(this),
                i = c.data("datepicker"),
                j = typeof b === "object" && b;
            if (!i) {
                c.data("datepicker", (i = new e(this, f.extend({}, f.fn.datepicker.defaults, j))))
            }
            if (typeof b === "string") {
                i[b](a)
            }
        })
    };
    f.fn.datepicker.defaults = {
        onRender: function (a) {
            return ""
        }
    };
    f.fn.datepicker.Constructor = e;
    var d = {
        modes: [{
            clsName: "days",
            navFnc: "Month",
            navStep: 1
        }, {
            clsName: "months",
            navFnc: "FullYear",
            navStep: 1
        }, {
            clsName: "years",
            navFnc: "FullYear",
            navStep: 10
        }],
        dates: {
            days: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
            daysShort: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
            daysMin: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"],
            months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
            monthsShort: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        },
        isLeapYear: function (a) {
            return (((a % 4 === 0) && (a % 100 !== 0)) || (a % 400 === 0))
        },
        getDaysInMonth: function (b, a) {
            return [31, (d.isLeapYear(b) ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][a]
        },
        parseFormat: function (a) {
            var b = a.match(/[.\/\-\s].*?/),
                c = a.split(/\W+/);
            if (!b || !c || c.length === 0) {
                throw new Error("Invalid date format.")
            }
            return {
                separator: b,
                parts: c
            }
        },
        parseDate: function (p, a) {
            var o = p.split(a.separator),
                p = new Date(),
                q;
            p.setHours(0);
            p.setMinutes(0);
            p.setSeconds(0);
            p.setMilliseconds(0);
            if (o.length === a.parts.length) {
                var c = p.getFullYear(),
                    b = p.getDate(),
                    i = p.getMonth();
                for (var n = 0, r = a.parts.length; n < r; n++) {
                    q = parseInt(o[n], 10) || 1;
                    switch (a.parts[n]) {
                        case "dd":
                        case "d":
                            b = q;
                            p.setDate(q);
                            break;
                        case "mm":
                        case "m":
                            i = q - 1;
                            p.setMonth(q - 1);
                            break;
                        case "yy":
                            c = 2000 + q;
                            p.setFullYear(2000 + q);
                            break;
                        case "yyyy":
                            c = q;
                            p.setFullYear(q);
                            break
                    }
                }
                p = new Date(c, i, b, 0, 0, 0)
            }
            return p
        },
        formatDate: function (j, b) {
            var a = {
                d: j.getDate(),
                m: j.getMonth() + 1,
                yy: j.getFullYear().toString().substring(2),
                yyyy: j.getFullYear()
            };
            a.dd = (a.d < 10 ? "0" : "") + a.d;
            a.mm = (a.m < 10 ? "0" : "") + a.m;
            var j = [];
            for (var c = 0, i = b.parts.length; c < i; c++) {
                j.push(a[b.parts[c]])
            }
            return j.join(b.separator)
        },
        headTemplate: '<thead><tr><th class="prev">&lsaquo;</th><th colspan="5" class="switch"></th><th class="next">&rsaquo;</th></tr></thead>',
        contTemplate: '<tbody><tr><td colspan="7"></td></tr></tbody>'
    };
    d.template = '<div class="datepicker dropdown-menu"><div class="datepicker-days"><table class=" table-condensed">' + d.headTemplate + '<tbody></tbody></table></div><div class="datepicker-months"><table class="table-condensed">' + d.headTemplate + d.contTemplate + '</table></div><div class="datepicker-years"><table class="table-condensed">' + d.headTemplate + d.contTemplate + "</table></div></div>"
}(window.jQuery);
/* ===========================================================
 * File input plugin
 * ========================================================== */
+ function (c) {
    var b = window.navigator.appName == "Microsoft Internet Explorer";
    var a = function (f, e) {
        this.$element = c(f);
        this.$input = this.$element.find(":file");
        if (this.$input.length === 0) {
            return
        }
        this.name = this.$input.attr("name") || e.name;
        this.$hidden = this.$element.find('input[type=hidden][name="' + this.name + '"]');
        if (this.$hidden.length === 0) {
            this.$hidden = c('<input type="hidden" />');
            this.$element.prepend(this.$hidden)
        }
        this.$preview = this.$element.find(".fileinput-preview");
        var d = this.$preview.css("height");
        if (this.$preview.css("display") != "inline" && d != "0px" && d != "none") {
            this.$preview.css("line-height", d)
        }
        this.original = {
            exists: this.$element.hasClass("fileinput-exists"),
            preview: this.$preview.html(),
            hiddenVal: this.$hidden.val()
        };
        this.listen()
    };
    a.prototype.listen = function () {
        this.$input.on("change.bs.fileinput", c.proxy(this.change, this));
        c(this.$input[0].form).on("reset.bs.fileinput", c.proxy(this.reset, this));
        this.$element.find('[data-trigger="fileinput"]').on("click.bs.fileinput", c.proxy(this.trigger, this));
        this.$element.find('[data-dismiss="fileinput"]').on("click.bs.fileinput", c.proxy(this.clear, this))
    }, a.prototype.change = function (i) {
        if (i.target.files === undefined) {
            i.target.files = i.target && i.target.value ? [{
                name: i.target.value.replace(/^.+\\/, "")
            }] : []
        }
        if (i.target.files.length === 0) {
            return
        }
        this.$hidden.val("");
        this.$hidden.attr("name", "");
        this.$input.attr("name", this.name);
        var g = i.target.files[0];
        if (this.$preview.length > 0 && (typeof g.type !== "undefined" ? g.type.match("image.*") : g.name.match(/\.(gif|png|jpe?g)$/i)) && typeof FileReader !== "undefined") {
            var d = new FileReader();
            var h = this.$preview;
            var f = this.$element;
            d.onload = function (j) {
                var e = c("<img>").attr("src", j.target.result);
                i.target.files[0].result = j.target.result;
                f.find(".fileinput-filename").text(g.name);
                if (h.css("max-height") != "none") {
                    e.css("max-height", parseInt(h.css("max-height"), 10) - parseInt(h.css("padding-top"), 10) - parseInt(h.css("padding-bottom"), 10) - parseInt(h.css("border-top"), 10) - parseInt(h.css("border-bottom"), 10))
                }
                h.html(e);
                f.addClass("fileinput-exists").removeClass("fileinput-new");
                f.trigger("change.bs.fileinput", i.target.files)
            };
            d.readAsDataURL(g)
        } else {
            this.$element.find(".fileinput-filename").text(g.name);
            this.$preview.text(g.name);
            this.$element.addClass("fileinput-exists").removeClass("fileinput-new");
            this.$element.trigger("change.bs.fileinput")
        }
    }, a.prototype.clear = function (f) {
        if (f) {
            f.preventDefault()
        }
        this.$hidden.val("");
        this.$hidden.attr("name", this.name);
        this.$input.attr("name", "");
        if (b) {
            var d = this.$input.clone(true);
            this.$input.after(d);
            this.$input.remove();
            this.$input = d
        } else {
            this.$input.val("")
        }
        this.$preview.html("");
        this.$element.find(".fileinput-filename").text("");
        this.$element.addClass("fileinput-new").removeClass("fileinput-exists");
        if (f !== false) {
            this.$input.trigger("change");
            this.$element.trigger("clear.bs.fileinput")
        }
    }, a.prototype.reset = function () {
        this.clear(false);
        this.$hidden.val(this.original.hiddenVal);
        this.$preview.html(this.original.preview);
        this.$element.find(".fileinput-filename").text("");
        if (this.original.exists) {
            this.$element.addClass("fileinput-exists").removeClass("fileinput-new")
        } else {
            this.$element.addClass("fileinput-new").removeClass("fileinput-exists")
        }
        this.$element.trigger("reset.bs.fileinput")
    }, a.prototype.trigger = function (d) {
        this.$input.trigger("click");
        d.preventDefault()
    };
    c.fn.fileinput = function (d) {
        return this.each(function () {
            var f = c(this),
                e = f.data("fileinput");
            if (!e) {
                f.data("fileinput", (e = new a(this, d)))
            }
            if (typeof d == "string") {
                e[d]()
            }
        })
    };
    c.fn.fileinput.Constructor = a;
    c(document).on("click.fileinput.data-api", '[data-provides="fileinput"]', function (g) {
        var f = c(this);
        if (f.data("fileinput")) {
            return
        }
        f.fileinput(f.data());
        var d = c(g.target).closest('[data-dismiss="fileinput"],[data-trigger="fileinput"]');
        if (d.length > 0) {
            g.preventDefault();
            d.trigger("click.bs.fileinput")
        }
    })
}(window.jQuery);
/* ===========================================================
 * Off-canvas plugin
 * ========================================================== */
+ function (b) {
    var c = function (f, e) {
        this.$element = b(f);
        this.$canvas = e.canvas ? b(e.canvas) : this.$element;
        this.options = b.extend({}, c.DEFAULTS, e);
        this.transitioning = null;
        this.calcTransform();
        if (!this.transform) {
            this.$canvas = this.$element
        }
        if (this.options.placement === "auto") {
            this.options.placement = this.calcPlacement()
        }
        if (this.options.recalc) {
            this.calcClone();
            b(window).on("resize.bs.offcanvas", b.proxy(this.recalc, this))
        }
        if (this.options.autohide) {
            b(document).on("click.bs.offcanvas", b.proxy(this.autohide, this))
        }
        var g = window.navigator.appName == "Microsoft Internet Explorer";
        if (g && this.$canvas !== this.$element) {
            var d = this.$canvas.find("*").filter(function () {
                return b(this).css("position") === "fixed"
            });
            this.$canvas = this.$canvas.add(d)
        }
        if (this.options.toggle) {
            this.toggle()
        }
    };
    c.DEFAULTS = {
        toggle: true,
        placement: "auto",
        autohide: true,
        recalc: true
    };
    c.prototype.calcTransform = function () {
        this.transform = false;
        if (!b.support.transition && this.$canvas === this.$element) {
            return
        }
        var e = b('<div style="visibility: hidden"></div>'),
            f = {
                transform: "transform",
                webkitTransform: "-webkit-transform",
                OTransform: "-o-transform",
                msTransform: "-ms-transform",
                MozTransform: "-moz-transform"
            };
        e.appendTo(b("body"));
        for (var g in f) {
            if (e[0].style[g] === undefined) {
                continue
            }
            e[0].style[g] = "translate3d(1px,1px,1px)";
            var d = window.getComputedStyle(e[0]).getPropertyValue(f[g]);
            this.transform = f[g];
            this.translate = d.match(/^matrix3d/) ? "translate3d" : "translate";
            break
        }
        e.remove()
    };
    c.prototype.calcPlacement = function () {
        var e = b(window).width() / this.$element.width(),
            f = b(window).height() / this.$element.height(),
            d = this.$element;

        function g(i, h) {
            if (d.css(h) === "auto") {
                return i
            }
            if (d.css(i) === "auto") {
                return h
            }
            var k = parseInt(d.css(i), 10),
                j = parseInt(d.css(h), 10);
            return k > j ? h : i
        }
        return e > f ? g("left", "right") : g("top", "bottom")
    };
    c.prototype.offset = function () {
        switch (this.options.placement) {
            case "left":
            case "right":
                return this.$element.outerWidth();
            case "top":
            case "bottom":
                return this.$element.outerHeight()
        }
    };
    c.prototype.slideTransform = function (f, h) {
        var e = this.options.placement,
            g = this.transform;
        f *= (e === "right" || e === "bottom" ? -1 : 1);
        var d = e === "left" || e === "right" ? "{}px, 0" : "0, {}px";
        if (this.translate === "translate3d") {
            d += ", 0"
        }
        d = this.translate + "(" + d + ")";
        if (!b.support.transition) {
            return this.$canvas.animate({
                borderSpacing: f
            }, {
                step: function (i, j) {
                    b(this).css(g, d.replace("{}", i))
                },
                complete: h,
                duration: 350
            })
        }
        this.$canvas.css(g, d.replace("{}", f));
        this.$element.one(b.support.transition.end, h).emulateTransitionEnd(350)
    };
    c.prototype.slidePosition = function (e, f) {
        if (!b.support.transition) {
            var d = {};
            d[this.options.placement] = e;
            return this.$canvas.animate(d, 350, f)
        }
        this.$canvas.css(this.options.placement, e);
        this.$element.one(b.support.transition.end, f).emulateTransitionEnd(350)
    };
    c.prototype.show = function () {
        if (this.transitioning || this.$canvas.hasClass("canvas-slid")) {
            return
        }
        var e = b.Event("show.bs.offcanvas");
        this.$element.trigger(e);
        if (e.isDefaultPrevented()) {
            return
        }
        var d = function () {
            this.$canvas.addClass("canvas-slid").removeClass("canvas-sliding");
            this.transitioning = 0;
            this.$element.trigger("shown.bs.offcanvas")
        };
        if (!this.$element.is(":visible") || !this.transform) {
            this.$element.css(this.options.placement, -1 * this.offset() + "px")
        }
        this.$element.addClass("in");
        this.$canvas.addClass("canvas-sliding");
        if (this.$canvas != this.$element) {
            b("body").css("overflow-x", "hidden")
        }
        this.transitioning = 1;
        if (this.transform) {
            this.slideTransform(this.offset(), b.proxy(d, this))
        } else {
            this.slidePosition(0, b.proxy(d, this))
        }
    };
    c.prototype.hide = function (f) {
        if (this.transitioning || !this.$canvas.hasClass("canvas-slid")) {
            return
        }
        var e = b.Event("hide.bs.offcanvas");
        this.$element.trigger(e);
        if (e.isDefaultPrevented()) {
            return
        }
        var d = function () {
            this.transitioning = 0;
            this.$element.removeClass("in").css("left", "").css("right", "").css("top", "").css("bottom", "");
            this.$canvas.removeClass("canvas-sliding canvas-slid").css("transform", "");
            b("body").css("overflow-x", "");
            this.$element.trigger("hidden.bs.offcanvas")
        };
        if (f) {
            return d.call(this)
        }
        this.$canvas.removeClass("canvas-slid").addClass("canvas-sliding");
        this.transitioning = 1;
        if (this.transform) {
            this.slideTransform(0, b.proxy(d, this))
        } else {
            this.slidePosition(-1 * this.offset(), b.proxy(d, this))
        }
    };
    c.prototype.toggle = function () {
        this[this.$canvas.hasClass("canvas-slid") ? "hide" : "show"]()
    };
    c.prototype.calcClone = function () {
        this.$calcClone = this.$element.clone().html("").addClass("offcanvas-clone").removeClass("in").appendTo(b("body"))
    };
    c.prototype.recalc = function () {
        if (this.$calcClone.css("display") !== "none") {
            this.hide(true)
        }
    };
    c.prototype.autohide = function (d) {
        if (b(d.target).closest(this.$element).length === 0) {
            this.hide()
        }
    };
    var a = b.fn.offcanvas;
    b.fn.offcanvas = function (d) {
        return this.each(function () {
            var g = b(this);
            var f = g.data("bs.offcanvas");
            var e = b.extend({}, c.DEFAULTS, g.data(), typeof d == "object" && d);
            if (!f) {
                g.data("bs.offcanvas", (f = new c(this, e)))
            }
            if (typeof d == "string") {
                f[d]()
            }
        })
    };
    b.fn.offcanvas.Constructor = c;
    b.fn.offcanvas.noConflict = function () {
        b.fn.offcanvas = a;
        return this
    };
    b(document).on("click.bs.offcanvas.data-api", "[data-toggle=offcanvas]", function (k) {
        var j = b(this),
            d;
        var i = j.attr("data-target") || k.preventDefault() || (d = j.attr("href")) && d.replace(/.*(?=#[^\s]+$)/, "");
        var g = b(i);
        var h = g.data("bs.offcanvas");
        var f = h ? "toggle" : j.data();
        k.stopPropagation();
        if (h) {
            h.toggle()
        } else {
            g.offcanvas(f)
        }
    })
}(window.jQuery);
/* ===========================================================
 * jQuery Google Map PLugin
 * ========================================================== */
(function (f) {
    var g = function () {
        this.markers = [];
        this.mainMarker = false;
        this.icon = "http://www.google.com/mapfiles/marker.png"
    };
    g.prototype.dist = function (h) {
        return Math.sqrt(Math.pow(this.markers[0].latitude - h.latitude, 2) + Math.pow(this.markers[0].longitude - h.longitude, 2))
    };
    g.prototype.setIcon = function (h) {
        this.icon = h
    };
    g.prototype.addMarker = function (h) {
        this.markers[this.markers.length] = h
    };
    g.prototype.getMarker = function () {
        if (this.mainmarker) {
            return this.mainmarker
        }
        var h, i;
        if (this.markers.length > 1) {
            h = new e.MarkerImage("http://thydzik.com/thydzikGoogleMap/markerlink.php?text=" + this.markers.length + "&color=EF9D3F");
            i = "cluster of " + this.markers.length + " markers"
        } else {
            h = new e.MarkerImage(this.icon);
            i = this.markers[0].title
        }
        this.mainmarker = new e.Marker({
            position: new e.LatLng(this.markers[0].latitude, this.markers[0].longitude),
            icon: h,
            title: i,
            map: null
        });
        return this.mainmarker
    };
    var e = google.maps,
        c = new e.Geocoder(),
        d = 0,
        b = 0,
        a = {};
    a = {
        init: function (i) {
            var h, j = f.extend({}, f.fn.gMap.defaults, i);
            for (h in f.fn.gMap.defaults.icon) {
                if (!j.icon[h]) {
                    j.icon[h] = f.fn.gMap.defaults.icon[h]
                }
            }
            return this.each(function () {
                var p = f(this),
                    k = a._getMapCenter.apply(p, [j]),
                    o, n;
                if (j.zoom == "fit") {
                    j.zoomFit = true;
                    j.zoom = a._autoZoom.apply(p, [j])
                }
                var m = {
                    zoom: j.zoom,
                    center: k,
                    mapTypeControl: j.mapTypeControl,
                    mapTypeControlOptions: {},
                    zoomControl: j.zoomControl,
                    zoomControlOptions: {},
                    panControl: j.panControl,
                    panControlOptions: {},
                    scaleControl: j.scaleControl,
                    scaleControlOptions: {},
                    streetViewControl: j.streetViewControl,
                    streetViewControlOptions: {},
                    mapTypeId: j.maptype,
                    scrollwheel: j.scrollwheel,
                    maxZoom: j.maxZoom,
                    minZoom: j.minZoom
                };
                if (j.controlsPositions.mapType) {
                    m.mapTypeControlOptions.position = j.controlsPositions.mapType
                }
                if (j.controlsPositions.zoom) {
                    m.zoomControlOptions.position = j.controlsPositions.zoom
                }
                if (j.controlsPositions.pan) {
                    m.panControlOptions.position = j.controlsPositions.pan
                }
                if (j.controlsPositions.scale) {
                    m.scaleControlOptions.position = j.controlsPositions.scale
                }
                if (j.controlsPositions.streetView) {
                    m.streetViewControlOptions.position = j.controlsPositions.streetView
                }
                if (j.styles) {
                    m.styles = j.styles
                }
                m.mapTypeControlOptions.style = j.controlsStyle.mapType;
                m.zoomControlOptions.style = j.controlsStyle.zoom;
                var l = new e.Map(this, m);
                if (j.log) {
                    console.log("map center is:")
                }
                if (j.log) {
                    console.log(k)
                }
                p.data("$gmap", l);
                p.data("gmap", {
                    opts: j,
                    gmap: l,
                    markers: [],
                    markerKeys: {},
                    infoWindow: null,
                    clusters: []
                });
                if (j.controls.length !== 0) {
                    for (o = 0; o < j.controls.length; o += 1) {
                        l.controls[j.controls[o].pos].push(j.controls[o].div)
                    }
                }
                if (j.clustering.enabled) {
                    n = p.data("gmap");
                    (function (q) {
                        n.markers = q
                    }(j.markers));
                    a._renderCluster.apply(p, []);
                    e.event.addListener(l, "bounds_changed", function () {
                        a._renderCluster.apply(p, [])
                    })
                } else {
                    if (j.markers.length !== 0) {
                        a.addMarkers.apply(p, [j.markers])
                    }
                }
                a._onComplete.apply(p, [])
            })
        },
        _delayedMode: false,
        _onComplete: function () {
            var i = this.data("gmap"),
                k = this;
            if (d !== 0) {
                window.setTimeout(function () {
                    a._onComplete.apply(k, [])
                }, 100);
                return
            }
            if (a._delayedMode) {
                var h = a._getMapCenter.apply(this, [i.opts, true]);
                a._setMapCenter.apply(this, [h]);
                if (i.opts.zoomFit) {
                    var j = a._autoZoom.apply(this, [i.opts, true]);
                    i.gmap.setZoom(j)
                }
            }
            i.opts.onComplete()
        },
        _setMapCenter: function (h) {
            var i = this.data("gmap");
            if (i && i.opts.log) {
                console.log("delayed setMapCenter called")
            }
            if (i && i.gmap !== undefined && d == 0) {
                i.gmap.setCenter(h)
            } else {
                var j = this;
                window.setTimeout(function () {
                    a._setMapCenter.apply(j, [h])
                }, 100)
            }
        },
        _boundaries: null,
        _getBoundaries: function (m) {
            var o = m.markers,
                k;
            var j = 1000,
                h = -1000,
                l = 1000,
                n = -1000;
            if (o) {
                for (k = 0; k < o.length; k += 1) {
                    if (!o[k].latitude || !o[k].longitude) {
                        continue
                    }
                    if (j > o[k].latitude) {
                        j = o[k].latitude
                    }
                    if (h < o[k].longitude) {
                        h = o[k].longitude
                    }
                    if (l > o[k].longitude) {
                        l = o[k].longitude
                    }
                    if (n < o[k].latitude) {
                        n = o[k].latitude
                    }
                    if (m.log) {
                        console.log(o[k].latitude, o[k].longitude, j, h, l, n)
                    }
                }
                a._boundaries = {
                    N: j,
                    E: h,
                    W: l,
                    S: n
                }
            }
            if (j == -1000) {
                a._boundaries = {
                    N: 0,
                    E: 0,
                    W: 0,
                    S: 0
                }
            }
            return a._boundaries
        },
        _getBoundariesFromMarkers: function () {
            var n = this.data("gmap").markers,
                k;
            var j = 1000,
                h = -1000,
                l = 1000,
                m = -1000;
            if (n) {
                for (k = 0; k < n.length; k += 1) {
                    if (j > n[k].getPosition().lat()) {
                        j = n[k].getPosition().lat()
                    }
                    if (h < n[k].getPosition().lng()) {
                        h = n[k].getPosition().lng()
                    }
                    if (l > n[k].getPosition().lng()) {
                        l = n[k].getPosition().lng()
                    }
                    if (m < n[k].getPosition().lat()) {
                        m = n[k].getPosition().lat()
                    }
                }
                a._boundaries = {
                    N: j,
                    E: h,
                    W: l,
                    S: m
                }
            }
            if (j == -1000) {
                a._boundaries = {
                    N: 0,
                    E: 0,
                    W: 0,
                    S: 0
                }
            }
            return a._boundaries
        },
        _getMapCenter: function (o, k) {
            var h, n = this,
                l, m, j;
            if (o.markers.length && (o.latitude == "fit" || o.longitude == "fit")) {
                if (k) {
                    j = a._getBoundariesFromMarkers.apply(this)
                } else {
                    j = a._getBoundaries(o)
                }
                h = new e.LatLng((j.N + j.S) / 2, (j.E + j.W) / 2);
                if (o.log) {
                    console.log(k, j, h)
                }
                return h
            }
            if (o.latitude && o.longitude) {
                h = new e.LatLng(o.latitude, o.longitude);
                return h
            } else {
                h = new e.LatLng(0, 0)
            } if (o.address) {
                c.geocode({
                    address: o.address
                }, function (i, p) {
                    if (p === google.maps.GeocoderStatus.OK) {
                        a._setMapCenter.apply(n, [i[0].geometry.location])
                    } else {
                        if (o.log) {
                            console.log("Geocode was not successful for the following reason: " + p)
                        }
                    }
                });
                return h
            }
            if (o.markers.length > 0) {
                m = null;
                for (l = 0; l < o.markers.length; l += 1) {
                    if (o.markers[l].setCenter) {
                        m = o.markers[l];
                        break
                    }
                }
                if (m === null) {
                    for (l = 0; l < o.markers.length; l += 1) {
                        if (o.markers[l].latitude && o.markers[l].longitude) {
                            m = o.markers[l];
                            break
                        }
                        if (o.markers[l].address) {
                            m = o.markers[l]
                        }
                    }
                }
                if (m === null) {
                    return h
                }
                if (m.latitude && m.longitude) {
                    return new e.LatLng(m.latitude, m.longitude)
                }
                if (m.address) {
                    c.geocode({
                        address: m.address
                    }, function (i, p) {
                        if (p === google.maps.GeocoderStatus.OK) {
                            a._setMapCenter.apply(n, [i[0].geometry.location])
                        } else {
                            if (o.log) {
                                console.log("Geocode was not successful for the following reason: " + p)
                            }
                        }
                    })
                }
            }
            return h
        },
        _renderCluster: function () {
            var l = this.data("gmap"),
                p = l.markers,
                w = l.clusters,
                h = l.opts,
                r, q, u;
            for (r = 0; r < w.length; r += 1) {
                w[r].getMarker().setMap(null)
            }
            w.length = 0;
            u = l.gmap.getBounds();
            if (!u) {
                var t = this;
                window.setTimeout(function () {
                    a._renderCluster.apply(t)
                }, 1000);
                return
            }
            var o = u.getNorthEast(),
                y = u.getSouthWest(),
                k = o.lat() - y.lat(),
                s = [],
                n, m, x = k * h.clustering.clusterSize / 100,
                v, z;
            for (r = 0; r < p.length; r += 1) {
                if (p[r].latitude < o.lat() && p[r].latitude > y.lat() && p[r].longitude < o.lng() && p[r].longitude > y.lng()) {
                    s[s.length] = p[r]
                }
            }
            if (h.log) {
                console.log("number of markers " + s.length + "/" + p.length)
            }
            if (h.log) {
                console.log("cluster radius: " + x)
            }
            for (r = 0; r < s.length; r += 1) {
                m = 10000;
                n = -1;
                for (q = 0; q < w.length; q += 1) {
                    v = w[q].dist(s[r]);
                    if (v < x) {
                        m = v;
                        n = q;
                        if (h.clustering.fastClustering) {
                            break
                        }
                    }
                }
                if (n === -1) {
                    z = new g();
                    z.addMarker(s[r]);
                    w[w.length] = z
                } else {
                    w[n].addMarker(s[r])
                }
            }
            if (h.log) {
                console.log("Total clusters in viewport: " + w.length)
            }
            for (q = 0; q < w.length; q += 1) {
                w[q].getMarker().setMap(l.gmap)
            }
        },
        _processMarker: function (o, q, s, r) {
            var k = this.data("gmap"),
                i = k.gmap,
                h = k.opts,
                n, m;
            if (r === undefined) {
                r = new e.LatLng(o.latitude, o.longitude)
            }
            if (!q) {
                var u = {
                    image: h.icon.image,
                    iconSize: new e.Size(h.icon.iconsize[0], h.icon.iconsize[1]),
                    iconAnchor: new e.Point(h.icon.iconanchor[0], h.icon.iconanchor[1]),
                    infoWindowAnchor: new e.Size(h.icon.infowindowanchor[0], h.icon.infowindowanchor[1])
                };
                q = new e.MarkerImage(u.image, u.iconSize, null, u.iconAnchor)
            }
            if (!s) {
                var p = {
                    image: h.icon.shadow,
                    iconSize: new e.Size(h.icon.shadowsize[0], h.icon.shadowsize[1]),
                    anchor: (u && u.iconAnchor) ? u.iconAnchor : new e.Point(h.icon.iconanchor[0], h.icon.iconanchor[1])
                }
            }
            m = {
                position: r,
                icon: q,
                title: o.title,
                map: null,
                draggable: ((o.draggable === true) ? true : false)
            };
            if (!h.clustering.enabled) {
                m.map = i
            }
            n = new e.Marker(m);
            n.setShadow(s);
            k.markers.push(n);
            if (o.key) {
                k.markerKeys[o.key] = n
            }
            var l;
            if (o.html) {
                var j = typeof (o.html) === "string" ? h.html_prepend + o.html + h.html_append : o.html;
                var t = {
                    content: j,
                    pixelOffset: o.infoWindowAnchor
                };
                if (h.log) {
                    console.log("setup popup with data")
                }
                if (h.log) {
                    console.log(t)
                }
                l = new e.InfoWindow(t);
                e.event.addListener(n, "click", function () {
                    if (h.log) {
                        console.log("opening popup " + o.html)
                    }
                    if (h.singleInfoWindow && k.infoWindow) {
                        k.infoWindow.close()
                    }
                    l.open(i, n);
                    k.infoWindow = l
                })
            }
            if (o.html && o.popup) {
                if (h.log) {
                    console.log("opening popup " + o.html)
                }
                l.open(i, n);
                k.infoWindow = l
            }
            if (o.onDragEnd) {
                e.event.addListener(n, "dragend", function (v) {
                    if (h.log) {
                        console.log("drag end")
                    }
                    o.onDragEnd(v)
                })
            }
        },
        _geocodeMarker: function (h, k, i) {
            var j = this;
            c.geocode({
                address: h.address
            }, function (m, l) {
                if (l === e.GeocoderStatus.OK) {
                    d -= 1;
                    if (j.data("gmap").opts.log) {
                        console.log("Geocode was successful with point: ", m[0].geometry.location)
                    }
                    a._processMarker.apply(j, [h, k, i, m[0].geometry.location])
                } else {
                    if (l === e.GeocoderStatus.OVER_QUERY_LIMIT) {
                        if ((!j.data("gmap").opts.noAlerts) && (b === 0)) {
                            alert("Error: too many geocoded addresses! Switching to 1 marker/s mode.")
                        }
                        b += 1000;
                        window.setTimeout(function () {
                            a._geocodeMarker.apply(j, [h, k, i])
                        }, b)
                    }
                    if (j.data("gmap").opts.log) {
                        console.log("Geocode was not successful for the following reason: " + l)
                    }
                }
            })
        },
        _autoZoom: function (q, p) {
            var m = f(this).data("gmap"),
                h = f.extend({}, m ? m.opts : {}, q),
                n, j, l, k, o = 39135.758482;
            if (h.log) {
                console.log("autozooming map")
            }
            if (p) {
                j = a._getBoundariesFromMarkers.apply(this)
            } else {
                j = a._getBoundaries(h)
            }
            l = (j.E - j.W) * 111000 / this.width();
            k = (j.S - j.N) * 111000 / this.height();
            for (n = 2; n < 20; n += 1) {
                if (l > o || k > o) {
                    break
                }
                o = o / 2
            }
            return n - 2
        },
        addMarkers: function (k) {
            var j = this.data("gmap").opts;
            if (k.length !== 0) {
                if (j.log) {
                    console.log("adding " + k.length + " markers")
                }
                for (var h = 0; h < k.length; h += 1) {
                    a.addMarker.apply(this, [k[h]])
                }
            }
        },
        addMarker: function (h) {
            var l = this.data("gmap").opts;
            if (l.log) {
                console.log("putting marker at " + h.latitude + ", " + h.longitude + " with address " + h.address + " and html " + h.html)
            }
            var j = {
                image: l.icon.image,
                iconSize: new e.Size(l.icon.iconsize[0], l.icon.iconsize[1]),
                iconAnchor: new e.Point(l.icon.iconanchor[0], l.icon.iconanchor[1]),
                infoWindowAnchor: new e.Size(l.icon.infowindowanchor[0], l.icon.infowindowanchor[1])
            }, i = {
                image: l.icon.shadow,
                iconSize: new e.Size(l.icon.shadowsize[0], l.icon.shadowsize[1]),
                anchor: new e.Point(l.icon.shadowanchor[0], l.icon.shadowanchor[1])
            };
            h.infoWindowAnchor = j.infoWindowAnchor;
            if (h.icon) {
                if (h.icon.image) {
                    j.image = h.icon.image
                }
                if (h.icon.iconsize) {
                    j.iconSize = new e.Size(h.icon.iconsize[0], h.icon.iconsize[1])
                }
                if (h.icon.iconanchor) {
                    j.iconAnchor = new e.Point(h.icon.iconanchor[0], h.icon.iconanchor[1])
                }
                if (h.icon.infowindowanchor) {
                    j.infoWindowAnchor = new e.Size(h.icon.infowindowanchor[0], h.icon.infowindowanchor[1])
                }
                if (h.icon.shadow) {
                    i.image = h.icon.shadow
                }
                if (h.icon.shadowsize) {
                    i.iconSize = new e.Size(h.icon.shadowsize[0], h.icon.shadowsize[1])
                }
                if (h.icon.shadowanchor) {
                    i.anchor = new e.Point(h.icon.shadowanchor[0], h.icon.shadowanchor[1])
                }
            }
            var m = new e.MarkerImage(j.image, j.iconSize, null, j.iconAnchor);
            var k = new e.MarkerImage(i.image, i.iconSize, null, i.anchor);
            if (h.address) {
                if (h.html === "_address") {
                    h.html = h.address
                }
                if (h.title == "_address") {
                    h.title = h.address
                }
                if (l.log) {
                    console.log("geocoding marker: " + h.address)
                }
                d += 1;
                a._delayedMode = true;
                a._geocodeMarker.apply(this, [h, m, k])
            } else {
                if (h.html === "_latlng") {
                    h.html = h.latitude + ", " + h.longitude
                }
                if (h.title == "_latlng") {
                    h.title = h.latitude + ", " + h.longitude
                }
                var n = new e.LatLng(h.latitude, h.longitude);
                a._processMarker.apply(this, [h, m, k, n])
            }
        },
        removeAllMarkers: function () {
            var j = this.data("gmap").markers,
                h;
            for (h = 0; h < j.length; h += 1) {
                j[h].setMap(null);
                delete j[h]
            }
            j.length = 0
        },
        getMarker: function (h) {
            return this.data("gmap").markerKeys[h]
        },
        fixAfterResize: function (i) {
            var h = this.data("gmap");
            e.event.trigger(h.gmap, "resize");
            if (i) {
                h.gmap.panTo(new google.maps.LatLng(0, 0))
            }
            h.gmap.panTo(this.gMap("_getMapCenter", h.opts))
        },
        setZoom: function (j, i, h) {
            var k = this.data("gmap").gmap;
            if (j === "fit") {
                j = a._autoZoom.apply(this, [i, h])
            }
            k.setZoom(parseInt(j))
        },
        changeSettings: function (h) {
            var k = this.data("gmap"),
                l = [],
                j;
            for (j = 0; j < k.markers.length; j += 1) {
                l[j] = {
                    latitude: k.markers[j].getPosition().lat(),
                    longitude: k.markers[j].getPosition().lng()
                }
            }
            h.markers = l;
            if (h.zoom) {
                a.setZoom.apply(this, [h.zoom, h])
            }
            if (h.latitude || h.longitude) {
                k.gmap.panTo(a._getMapCenter.apply(this, [h]))
            }
        },
        mapclick: function (h) {
            google.maps.event.addListener(this.data("gmap").gmap, "click", function (i) {
                h(i.latLng)
            })
        },
        geocode: function (h, j, i) {
            c.geocode({
                address: h
            }, function (l, k) {
                if (k === e.GeocoderStatus.OK) {
                    j(l[0].geometry.location)
                } else {
                    if (i) {
                        i(l, k)
                    }
                }
            })
        },
        getRoute: function (s) {
            var m = this.data("gmap"),
                i = m.gmap,
                r = new e.DirectionsRenderer(),
                q = new e.DirectionsService(),
                k = {
                    BYCAR: e.DirectionsTravelMode.DRIVING,
                    BYBICYCLE: e.DirectionsTravelMode.BICYCLING,
                    BYFOOT: e.DirectionsTravelMode.WALKING
                }, p = {
                    MILES: e.DirectionsUnitSystem.IMPERIAL,
                    KM: e.DirectionsUnitSystem.METRIC
                }, l = null,
                h = null,
                o = null,
                j = null;
            if (s.routeDisplay !== undefined) {
                l = (s.routeDisplay instanceof jQuery) ? s.routeDisplay[0] : ((typeof s.routeDisplay == "string") ? f(s.routeDisplay)[0] : null)
            } else {
                if (m.opts.routeFinder.routeDisplay !== null) {
                    l = (m.opts.routeFinder.routeDisplay instanceof jQuery) ? m.opts.routeFinder.routeDisplay[0] : ((typeof m.opts.routeFinder.routeDisplay == "string") ? f(m.opts.routeFinder.routeDisplay)[0] : null)
                }
            }
            r.setMap(i);
            if (l !== null) {
                r.setPanel(l)
            }
            h = (k[m.opts.routeFinder.travelMode] !== undefined) ? k[m.opts.routeFinder.travelMode] : k.BYCAR;
            o = (p[m.opts.routeFinder.travelUnit] !== undefined) ? p[m.opts.routeFinder.travelUnit] : p.KM;
            var n = {
                origin: s.from,
                destination: s.to,
                travelMode: h,
                unitSystem: o
            };
            q.route(n, function (t, u) {
                if (u == e.DirectionsStatus.OK) {
                    r.setDirections(t)
                } else {
                    if (l !== null) {
                        f(l).html(m.opts.routeFinder.routeErrors[u])
                    }
                }
            });
            return this
        }
    };
    f.fn.gMap = function (h) {
        if (a[h]) {
            return a[h].apply(this, Array.prototype.slice.call(arguments, 1))
        } else {
            if (typeof h === "object" || !h) {
                return a.init.apply(this, arguments)
            } else {
                f.error("Method " + h + " does not exist on jQuery.gmap")
            }
        }
    };
    f.fn.gMap.defaults = {
        log: false,
        address: "",
        latitude: null,
        longitude: null,
        zoom: 3,
        maxZoom: null,
        minZoom: null,
        markers: [],
        controls: {},
        scrollwheel: true,
        maptype: google.maps.MapTypeId.ROADMAP,
        mapTypeControl: true,
        zoomControl: true,
        panControl: false,
        scaleControl: false,
        streetViewControl: true,
        controlsPositions: {
            mapType: null,
            zoom: null,
            pan: null,
            scale: null,
            streetView: null
        },
        controlsStyle: {
            mapType: google.maps.MapTypeControlStyle.DEFAULT,
            zoom: google.maps.ZoomControlStyle.DEFAULT
        },
        singleInfoWindow: true,
        html_prepend: '<div class="gmap_marker">',
        html_append: "</div>",
        icon: {
            image: "http://www.google.com/mapfiles/marker.png",
            iconsize: [20, 34],
            iconanchor: [9, 34],
            infowindowanchor: [9, 2],
            shadow: "http://www.google.com/mapfiles/shadow50.png",
            shadowsize: [37, 34],
            shadowanchor: [9, 34]
        },
        onComplete: function () {},
        routeFinder: {
            travelMode: "BYCAR",
            travelUnit: "KM",
            routeDisplay: null,
            routeErrors: {
                INVALID_REQUEST: "The provided request is invalid.",
                NOT_FOUND: "One or more of the given addresses could not be found.",
                OVER_QUERY_LIMIT: "A temporary error occured. Please try again in a few minutes.",
                REQUEST_DENIED: "An error occured. Please contact us.",
                UNKNOWN_ERROR: "An unknown error occured. Please try again.",
                ZERO_RESULTS: "No route could be found within the given addresses."
            }
        },
        clustering: {
            enabled: false,
            fastClustering: false,
            clusterCount: 10,
            clusterSize: 40
        }
    }
}(jQuery));