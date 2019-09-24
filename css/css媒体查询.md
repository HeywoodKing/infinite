1.媒体查询media  最小宽度
超小设备，手持手机等
@media (min-width: 576px){...}
小等设备，平板等
@media (min-width: 768px){...}
中等设备，台式机
@media (min-width: 992px){...}
大设备
@media (min-width: 1200px){...}


超小设备，手持手机等  最大宽度
@media (max-width: 575.98px){...}
小等设备，平板等
@media (max-width: 767.98px){...}
中等设备，台式机
@media (max-width: 991.98px){...}
大设备
@media (max-width: 1199.98px){...}


超小设备
@media (max-width: 575.98px){...}
小设备
@media (min-width: 576px) and (max-width: 767.98px){...}
中等设备
@media (min-width: 768px) and (max-width: 991.98px){...}
大设备
@media (min-width: 992px) and (max-width: 1199.98px){...}
超大设备
@media (min-width: 1200px){...}



2. breakpoint Sass via Sass mixins
@include media-breakpoint-up(xs){...}
@include media-breakpoint-up(sm){...}
@include media-breakpoint-up(md){...}
@include media-breakpoint-up(lg){...}
@include media-breakpoint-up(xl){...}
// Example usage:
@include media-breakpoint-up(sm) {
  .some-class {
    display: block;
  }
}


@include media-breakpoint-down(xs){...}
@include media-breakpoint-down(sm){...}
@include media-breakpoint-down(md){...}
@include media-breakpoint-down(lg){...}


@include media-breakpoint-only(xs){...}
@include media-breakpoint-only(sm){...}
@include media-breakpoint-only(md){...}
@include media-breakpoint-only(lg){...}
@include media-breakpoint-only(xl){...}



eg:
@include media-breakpoint-between(md, xl){...}
