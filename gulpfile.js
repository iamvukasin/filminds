const { src, dest, parallel, series, watch } = require("gulp");
const sass = require("gulp-sass");
const minifyCSS = require("gulp-csso");
const svgo = require("gulp-svgo");
const browsersync = require("browser-sync").create();

function html() {
    return src("src/*.html")
        .pipe(dest("dist/"))
}

function css() {
    return src("src/sass/*.scss")
        .pipe(sass({ includePaths: ['node_modules/'] }))
        .pipe(minifyCSS())
        .pipe(dest("dist/css"))
}

function svgImages() {
    return src("src/images/*.svg")
        .pipe(svgo())
        .pipe(dest("dist/images"));
}

function run(done) {
    browsersync.init({
        server: {
            baseDir: "dist/"
        },
        port: 3000
    });
    done();
}

function reload(done) {
    browsersync.reload();
    done();
}

function watchFiles() {
    watch("src/sass/**/*.scss", series(css, reload));
    watch("src/**/*.html", series(html, reload));
    watch("src/images/*.svg", series(svgImages, reload));
}

// complex tasks
const build = parallel(html, css, svgImages);
const serve = series(
    build,
    parallel(watchFiles, run)
);

exports.css = css;
exports.html = html;
exports.images = svgImages;
exports.serve = serve;
exports.default = build;
