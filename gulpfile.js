const { src, dest, parallel, series, watch } = require("gulp");
const sass = require("gulp-sass");
const minifyCSS = require("gulp-csso");
const svgo = require("gulp-svgo");
const babelify = require("babelify")
const browserify = require("browserify");
const source = require("vinyl-source-stream");
const buffer = require("vinyl-buffer");
const browsersync = require("browser-sync").create();
const del = require("del");
const uglify = require("gulp-uglify");
const exec = require('child_process').exec;

const destinationFolder = "app/static";

function css() {
    return src("src/sass/*.scss")
        .pipe(sass({ includePaths: ['node_modules/'] }))
        .pipe(minifyCSS())
        .pipe(dest(destinationFolder + "/css"))
}

function scripts() {
    return browserify({
            entries: ["src/scripts/main.js"]
        })
        .transform(babelify.configure({
            presets: ["@babel/preset-env"]
        }))
        .bundle()
        .pipe(source("main.js"))
        .pipe(buffer())
        .pipe(uglify())
        .pipe(dest(destinationFolder + "/scripts"))
        .pipe(browsersync.stream());
}

function svgImages() {
    return src("src/images/*.svg")
        .pipe(svgo())
        .pipe(dest(destinationFolder + "/images"));
}

function rasterImages() {
    return src([
            "src/images/*.png",
            "src/images/*.jpg",
            "src/images/*.ico"
        ])
        .pipe(dest(destinationFolder + "/images"));
}

function runServer(done) {
    exec("python manage.py runserver");
    done();
}

function run(done) {
    browsersync.init({
        notify: false,
        port: 8000,
        proxy: "localhost:8000"
    });
    done();
}

function reload(done) {
    browsersync.reload();
    done();
}

function clean() {
    return del([destinationFolder]);
}

function watchFiles() {
    watch("src/sass/**/*.scss", series(css, reload));
    watch("**/*.html", reload);
    watch("src/scripts/*.js", series(scripts, reload));
    watch("src/images/*.svg", series(svgImages, reload));
    watch(["src/images/*.png", "src/images/*.jpg"], series(rasterImages, reload));
}

// complex tasks
const build = series(
    clean,
    parallel(css, scripts, svgImages, rasterImages)
);
const serve = series(
    build,
    runServer,
    parallel(watchFiles, run)
);

exports.css = css;
exports.scripts = scripts;
exports.images = svgImages;
exports.serve = serve;
exports.clean = clean;
exports.default = build;
